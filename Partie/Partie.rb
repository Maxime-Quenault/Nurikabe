load "Partie/Grille.rb"
load "Partie/Coup.rb"
load "Partie/Indice.rb"
# Représentes une partie, contient :
# une grille en cours, sur laquelle on va jouer
# un chronomètre
# un tableau de coups, sert pour les undo et redo
# un indice du coup auquel on est
# un booléen en pause
class Partie
  @grilleEnCours
  @chronometre
  @tabCoup
  @indiceCoup
  @enPause

  attr_accessor :grilleEnCours

  def Partie.creeToi(uneGrille)
    new(uneGrille)
  end
  private_class_method :new

  attr :grilleEnCours, false
  attr :chronometre, false
  attr :tabCoup, false
  attr :indiceCoup, false
  attr :enPause, false
  def initialize(uneGrille)
    @grilleEnCours=uneGrille
    @tabCoup=Array.new()
    @indiceCoup=0
    @enPause=false
    #@chronometre=Chronometre.creer()
  end

  # ajoutes le coup passé en paramètre au tableau de coups et incrémente l'indiceCoup
  def nouveauCoup(unCoup)
    @tabCoup[@indiceCoup]=unCoup
    @indiceCoup+=1
  end

  # changes l'état de la case cliquée et créer un nouveau coup correspondant, supprimmes les coups suivants
  def clicSurCase(x,y)
    if(@grilleEnCours.matriceCases[x][y].is_a?(CaseJouable))
	  	anc_etat =@grilleEnCours.matriceCases[x][y].etat
      @grilleEnCours.matriceCases[x][y].changerEtat
		  self.nouveauCoup(Coup.creer(@grilleEnCours.matriceCases[x][y],anc_etat,@grilleEnCours.matriceCases[x][y].etat))
      if(tabCoup[@indiceCoup].is_a?(Coup))
        i=@indiceCoup
        while(tabCoup[i].is_a?(Coup))
          tabCoup[i]=nil
          i+=1
        end
      end
    end
  end

  # vrai si on peut undo, faux sinon
  def undoPossible?()
    return @indiceCoup>0
  end

  # Retournes à l'état précédant le dernier clic sur une case
  def undo()
    if(self.undoPossible?)
      tmpEtat=@tabCoup[@indiceCoup-1].case.etat
      tmpCase=@tabCoup[@indiceCoup-1].case
      @tabCoup[@indiceCoup-1].case.etat=@tabCoup[@indiceCoup-1].ancienEtat
      @indiceCoup-=1
    end
  end

  # vrai si on peut redo, faux sinon
  def redoPossible?()
	   return @tabCoup[@indiceCoup].is_a?(Coup)
  end

  # Retournes à l'état suivant
  def redo()
    if(self.redoPossible?)
      @tabCoup[indiceCoup].case.etat=@tabCoup[indiceCoup].etat
      @indiceCoup+=1
    end
  end

  # Remet les variables d'instance à 0
  def raz()
    @grilleEnCours.raz()
    @tabCoup=Array.new()
    @indiceCoup=0
    @enPause=false
  end

  #vrai si la partie est finie faux sinon
  def partieFinie?()
    return @grilleEnCours.grilleFinie
  end

  #undo tant qu'il y a des erreurs
  def reviensALaBonnePosition()
    while(@grilleEnCours.nbErreurs>0)
      self.undo
    end
  end

  def metToiEnPause()
  end

  def reprend()
  end

  # Recherche et retourne les coordonnées d'une case Ile de valeur 1 non entourée (si elle existe, sinon on retourne nil)
  def indice_ile1NonEntouree()
    for i in 0..@grilleEnCours.largeur-1
      for j in 0..@grilleEnCours.hauteur-1
        # On regarde si une case est une case ile de valeur 1 et si les cases autours ne sont pas jouées
        if @grilleEnCours.matriceCases[i][j].is_a?(CaseNombre) && @grilleEnCours.matriceCases[i][j].valeur==1
          if i+1 < @grilleEnCours.largeur && @grilleEnCours.matriceCases[i+1][j].etat==0
            return Indice.creer(:ile1NonEntouree,[i,j])
          elsif j+1 < @grilleEnCours.hauteur && @grilleEnCours.matriceCases[i][j+1].etat==0
            return Indice.creer(:ile1NonEntouree,[i,j])
          elsif j-1 >= 0 && @grilleEnCours.matriceCases[i][j-1].etat==0 
            return Indice.creer(:ile1NonEntouree,[i,j])
          elsif i-1 >= 0 && @grilleEnCours.matriceCases[i-1][j].etat==0
            return Indice.creer(:ile1NonEntouree,[i,j])
          end
        end
      end
    end
    return nil
  end

  # Recherche et retourne les coordonnées d'une case jouable non jouée séparant deux cases îles (si elle existe, sinon on retourne nil)
  def indice_IlesVoisinesNonSeparees()
    for j in 0..@grilleEnCours.hauteur-1
      for i in 0..@grilleEnCours.largeur-1
        # On regarde si il existe deux cases îles séparées par une case jouable non jouée
        if @grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
          if i+2 < @grilleEnCours.largeur-1 && @grilleEnCours.matriceCases[i+1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i+1][j].etat==0 && @grilleEnCours.matriceCases[i+2][j].is_a?(CaseNombre)
            return Indice.creer(:ilesVoisinesNonSeparees,[i+1,j])
          elsif j+2 < @grilleEnCours.hauteur-1 && @grilleEnCours.matriceCases[i][j+1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j+1].etat==0 && @grilleEnCours.matriceCases[i][j+2].is_a?(CaseNombre)
            return Indice.creer(:ilesVoisinesNonSeparees,[i,j+1])
          elsif j-2 >= 0 && @grilleEnCours.matriceCases[i][j-1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j-1].etat==0 && @grilleEnCours.matriceCases[i][j-2].is_a?(CaseNombre)
            return Indice.creer(:ilesVoisinesNonSeparees,[i,j-1])
          elsif i-2 >= 0 && @grilleEnCours.matriceCases[i-1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i-1][j].etat==0 && @grilleEnCours.matriceCases[i-2][j].is_a?(CaseNombre)
            return Indice.creer(:ilesVoisinesNonSeparees,[i-1,j])
          end
        end
      end
    end
    return nil
  end

  # Recherche et retourne les coordonnées d'une case jouable non jouée séparant deux cases îles en diagonales (si elle existe, sinon on retourne nil)
  def indice_IlesDiagonalesNonSeparees()
    for j in 0..@grilleEnCours.hauteur-1
      for i in 0..@grilleEnCours.largeur-1
        if @grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
          if i+1 < @grilleEnCours.largeur-1 && j+1 < @grilleEnCours.hauteur-1 && @grilleEnCours.matriceCases[i+1][j+1].is_a?(CaseNombre)
            if @grilleEnCours.matriceCases[i+1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i+1][j].etat==0
              return Indice.creer(:ilesDiagonalesNonSeparees,[i+1,j])
            elsif @grilleEnCours.matriceCases[i][j+1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j+1].etat==0
              return Indice.creer(:ilesDiagonalesNonSeparees,[i,j+1])
            end
          end
          if i+1 < @grilleEnCours.largeur-1 && j-1 >= 0 && @grilleEnCours.matriceCases[i+1][j-1].is_a?(CaseNombre)
            if @grilleEnCours.matriceCases[i+1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i+1][j].etat==0
              return Indice.creer(:ilesDiagonalesNonSeparees,[i+1,j])
            elsif @grilleEnCours.matriceCases[i][j-1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j-1].etat==0
              return Indice.creer(:ilesDiagonalesNonSeparees,[i,j-1])
            end
          end
          if i-1 >= 0 && j+1 < @grilleEnCours.hauteur-1 && @grilleEnCours.matriceCases[i-1][j+1].is_a?(CaseNombre)
            if @grilleEnCours.matriceCases[i-1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i-1][j].etat==0
              return Indice.creer(:ilesDiagonalesNonSeparees,[i-1,j])
            elsif @grilleEnCours.matriceCases[i][j+1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j+1].etat==0
              return Indice.creer(:ilesDiagonalesNonSeparees,[i,j+1])
            end
          end
          if i-1 >= 0 && j-1 >= 0 && @grilleEnCours.matriceCases[i-1][j-1].is_a?(CaseNombre)
            if @grilleEnCours.matriceCases[i-1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i-1][j].etat==0
              return Indice.creer(:ilesDiagonalesNonSeparees,[i-1,j])
            elsif @grilleEnCours.matriceCases[i][j-1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j-1].etat==0
              return Indice.creer(:ilesDiagonalesNonSeparees,[i,j-1])
            end
          end
        end
      end
    end
    return nil
  end

  # Recherche un carré de cases océan de taille 2x2 et retourne ses coordonnées (si il existe, sinon on retourne nil)
  def indice_Ocean2x2()
    for j in 0..@grilleEnCours.hauteur-2
      for i in 0..@grilleEnCours.largeur-2
        # si les cases aux coordonnées [i,j],[i+1,j],[i,j+1],[i+1,j+1] sont jouables et ont l'état océan, on retourne les coordonnées i,j
        if @grilleEnCours.matriceCases[i][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i+1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j+1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i+1][j+1].is_a?(CaseJouable) 
          if @grilleEnCours.matriceCases[i][j].etat==1 && @grilleEnCours.matriceCases[i+1][j].etat==1 && @grilleEnCours.matriceCases[i][j+1].etat==1 && @grilleEnCours.matriceCases[i+1][j+1].etat==1 
            return(Indice.creer(:ocean2x2,[i,j]))
          end
        end
      end
    end
    return nil
  end

  # Recherche une case jouable (avec l'état non joué ou île) entourée de cases océan ou des bords le la grille (si elle existe, sinon on retourne nil)
  def indice_caseJouableIsolee()
    for j in 0..@grilleEnCours.hauteur-1
      for i in 0..@grilleEnCours.largeur-1
        gauche = false
        droite = false
        bas = false
        haut = false
        if @grilleEnCours.matriceCases[i][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j].etat!=1
          if(i==0 || @grilleEnCours.matriceCases[i-1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i-1][j].etat==1)
            gauche = true
          end 
          if(j==0 || @grilleEnCours.matriceCases[i][j-1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j-1].etat==1)
            haut = true
          end
          if(j==@grilleEnCours.hauteur-1 || @grilleEnCours.matriceCases[i][j+1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j+1].etat==1)
            bas = true
          end
          if(i==@grilleEnCours.largeur-1 || @grilleEnCours.matriceCases[i+1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i+1][j].etat==1)
            droite = true
          end
        end
        if(gauche && droite && haut && bas)
          return(Indice.creer(:caseJouableIsolee, [i,j]))
        end
      end
    end
    return nil
  end

  
  # Retourne les coordonnées de la case adjacente à celle aux coordonnées passées en paramètres si cetter dernière n'est accessible que d'une seule case
  def caseJouableAccessibleQueDUneDirection(i,j)
    gaucheNonJouable = false
    droiteNonJouable = false
    hautNonJouable = false
    basNonJouable = false
    if (j==0 || @grilleEnCours.matriceCases[i][j-1].is_a?(CaseNombre))
      hautNonJouable=true
    end
    if (i==0 || @grilleEnCours.matriceCases[i-1][j].is_a?(CaseNombre))
      gaucheNonJouable=true
    end
    if (j==@grilleEnCours.hauteur-1 || @grilleEnCours.matriceCases[i][j+1].is_a?(CaseNombre))
      basNonJouable=true
    end
    if(i==@grilleEnCours.largeur-1 || @grilleEnCours.matriceCases[i+1][j].is_a?(CaseNombre))
      droiteNonJouable=true
    end
    
    if(gaucheNonJouable && droiteNonJouable && basNonJouable && !hautNonJouable && @grilleEnCours.matriceCases[i][j-1].etat==0)
      return [i,j-1]
    elsif(gaucheNonJouable && droiteNonJouable && !basNonJouable && hautNonJouable && @grilleEnCours.matriceCases[i][j+1].etat==0)
      return [i,j+1]
    elsif(gaucheNonJouable && !droiteNonJouable && basNonJouable && hautNonJouable && @grilleEnCours.matriceCases[i+1][j].etat==0) 
      return [i+1,j]
    elsif(!gaucheNonJouable && droiteNonJouable && basNonJouable && hautNonJouable && @grilleEnCours.matriceCases[i-1][j].etat==0)
      return [i-1,j]
    else
      return nil
    end
      
  end

  # Recherche si un "mur" peut être étendu en mettant une case jouable à l'état océan et on retourne ses coordonnées (si elle existe, sinon on retourne nil)
  def indice_expansionMur()
    for i in 0..@grilleEnCours.largeur-1
      for j in 0..@grilleEnCours.hauteur-1
        if @grilleEnCours.matriceCases[i][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j].etat==1 && caseJouableAccessibleQueDUneDirection(i,j)!=nil
            return Indice.creer(:expansionMur,caseJouableAccessibleQueDUneDirection(i,j))
        end
      end
    end
    return nil
  end

  # Retourne les coordonnées de la case adjacente à celle aux coordonnées passées en paramètres si cetter dernière n'est accessible que d'une seule case
  def caseNombreAccessibleQueDUneDirection(i,j)
    gaucheNonJouable = false
    droiteNonJouable = false
    hautNonJouable = false
    basNonJouable = false
    if (j==0 || @grilleEnCours.matriceCases[i][j-1].is_a?(CaseJouable) &&  @grilleEnCours.matriceCases[i][j-1].etat==1)
      hautNonJouable=true
    end
    if (i==0 || @grilleEnCours.matriceCases[i-1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i-1][j].etat==1)
      gaucheNonJouable=true
    end
    if (j==@grilleEnCours.hauteur-1 || @grilleEnCours.matriceCases[i][j+1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j+1].etat==1)
      basNonJouable=true
    end
    if(i==@grilleEnCours.largeur-1 || @grilleEnCours.matriceCases[i+1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i+1][j].etat==1)
      droiteNonJouable=true
    end
    
    if(gaucheNonJouable && droiteNonJouable && basNonJouable && !hautNonJouable && @grilleEnCours.matriceCases[i][j-1].etat==0)
      return [i,j-1]
    elsif(gaucheNonJouable && droiteNonJouable && !basNonJouable && hautNonJouable && @grilleEnCours.matriceCases[i][j+1].etat==0)
      return [i,j+1]
    elsif(gaucheNonJouable && !droiteNonJouable && basNonJouable && hautNonJouable && @grilleEnCours.matriceCases[i+1][j].etat==0) 
      return [i+1,j]
    elsif(!gaucheNonJouable && droiteNonJouable && basNonJouable && hautNonJouable && @grilleEnCours.matriceCases[i-1][j].etat==0)
      return [i-1,j]
    else
      return nil
    end
  end
        
  # Recherche si une île peut être étendue en mettant une case jouable à l'état île et on retourne ses coordonnées (si elle existe, sinon on retourne nil)
  def indice_expansionIle()
    for i in 0..@grilleEnCours.largeur-1
      for j in 0..@grilleEnCours.hauteur-1
        if @grilleEnCours.matriceCases[i][j].is_a?(CaseNombre) && @grilleEnCours.matriceCases[i][j].valeur>1 && caseNombreAccessibleQueDUneDirection(i,j)!=nil
            return Indice.creer(:expansionIle,caseNombreAccessibleQueDUneDirection(i,j))
        end
      end
    end
    return nil
  end
    

  # Cherche si il y a un indice à donner à l'utilisateur dans l'ordre du plus simple au plus complexe et le retourne (si il existe, sinon on retourne nil)
  def clicSurIndice()
    indice = self.indice_ile1NonEntouree
    if indice!=nil
      return indice
    else
      indice = self.indice_Ocean2x2
      if indice!=nil
        return indice
      else
        indice = self.indice_caseJouableIsolee
        if indice!=nil
          return indice
        else
          indice = self.indice_IlesVoisinesNonSeparees 
          if indice!=nil
            return indice
          else 
            indice = self.indice_IlesDiagonalesNonSeparees
            if indice!=nil
              return indice
            else  
              indice = self.indice_expansionMur
              if indice!=nil
                return indice
              else  
                indice = self.indice_expansionIle
                if indice!=nil
                  return indice
                else  
                  return Indice.creer(nil,nil)
                end
              end
            end
          end
        end
      end
    end
  end
    
end
