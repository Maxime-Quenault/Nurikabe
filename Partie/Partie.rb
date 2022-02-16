require './Grille'
require './Coup'
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

  # changes l'état de la case cliquée et créer un nouveau coup correspondant
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
    @tabCoup[indiceCoup].case.etat=@tabCoup[indiceCoup].etat
    @indiceCoup+=1
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
      puts @grilleEnCours
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
            return [i,j]
          elsif j+1 < @grilleEnCours.hauteur && @grilleEnCours.matriceCases[i][j+1].etat==0
            return [i,j]
          elsif j-1 >= 0 && @grilleEnCours.matriceCases[i][j-1].etat==0 
            return [i,j]
          elsif i-1 >= 0 && @grilleEnCours.matriceCases[i-1][j].etat==0
            return [i,j]
          end
        end
      end
    end
    return nil
  end

  # NON TESTEE POUR LINSANT IL FAUT FAIRE UNE AUTRE GRILLE DANS LE FICHIER TEST
  # Recherche et retourne les coordonnées d'une case jouable non jouée séparant deux cases îles (si elle existe, sinon on retourne nil)
  def indice_IlesVoisinesNonSeparees()
    for i in 0..@grilleEnCours.hauteur-1
      for j in 0..@grilleEnCours.largeur-1
        # On regarde si il existe deux cases îles séparées par une case jouable non jouée
        if @grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
          if i+2 < @grilleEnCours.hauteur-1 && @grilleEnCours.matriceCases[i+1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i+1][j].etat==0 && @grilleEnCours.matriceCases[i+2][j].is_a?(CaseNombre)
            return [i+1,j]
          elsif j+2 < @grilleEnCours.largeur-1 && @grilleEnCours.matriceCases[i][j+1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j+1].etat==0 && @grilleEnCours.matriceCases[i][j+2].is_a?(CaseNombre)
            return [i,j+1]
          elsif j-2 >= 0 && @grilleEnCours.matriceCases[i][j-1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j-1].etat==0 && @grilleEnCours.matriceCases[i][j-2].is_a?(CaseNombre)
            return [i,j-1]
          elsif i-2 >= 0 && @grilleEnCours.matriceCases[i-1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i-1][j].etat==0 && @grilleEnCours.matriceCases[i-2][j].is_a?(CaseNombre)
            return [i-1,j]
          end
        end
      end
    end
    return nil
  end

  # Recherche et retourne les coordonnées d'une case jouable non jouée séparant deux cases îles en diagonales (si elle existe, sinon on retourne nil)
  def indice_IlesDiagonalesNonSeparees()
    for i in 0..@grilleEnCours.hauteur-1
      for j in 0..@grilleEnCours.largeur-1
        if @grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
          if i+1 < @grilleEnCours.matriceCases.size && j+1 < @grilleEnCours.matriceCases.size && @grilleEnCours.matriceCases[i+1][j+1].is_a?(CaseNombre)
            if @grilleEnCours.matriceCases[i+1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i+1][j].etat==0
              return [i+1,j]
            elsif @grilleEnCours.matriceCases[i][j+1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j+1].etat==0
              return [i,j+1]
            end
          end
          if i+1 < @grilleEnCours.matriceCases.size && j-1 >= 0 && @grilleEnCours.matriceCases[i+1][j-1].is_a?(CaseNombre)
            if @grilleEnCours.matriceCases[i+1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i+1][j].etat==0
              return [i+1,j]
            elsif @grilleEnCours.matriceCases[i][j-1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j-1].etat==0
              return [i,j-1]
            end
          end
          if i-1 >= 0 && j+1 < @grilleEnCours.matriceCases.size && @grilleEnCours.matriceCases[i-1][j+1].is_a?(CaseNombre)
            if @grilleEnCours.matriceCases[i-1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i-1][j].etat==0
              return [i-1,j]
            elsif @grilleEnCours.matriceCases[i][j+1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j+1].etat==0
              return [i,j+1]
            end
          end
          if i-1 >= 0 && j-1 >= 0 && @grilleEnCours.matriceCases[i-1][j-1].is_a?(CaseNombre)
            if @grilleEnCours.matriceCases[i-1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i-1][j].etat==0
              return [i-1,j]
            elsif @grilleEnCours.matriceCases[i][j-1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j-1].etat==0
              return [i,j-1]
            end
          end
        end
      end
    end
    return nil
  end
    
end
