load "Partie/Grille.rb"
load "Partie/Coup.rb"
load "Partie/Indice.rb"
load "Chrono/Chronometre.rb"

=begin
  @author Julian LEBOUC
  La classe Partie permet de :::
    - représenter une partie
    - jouer sur une grille
    - connaître le temps grâce à un chronomêtre
    - faire des undo redo grâce à un système d'undo/redo

    Les VI de la classe sont :::

      - @grilleEnCours  ==> grille sur laquelle le joueur évolue
      - @chronometre    ==> temps de jeu sur la grille
      - @tabCoup        ==> tableau contenant les coups joués
      - @indiceCoup     ==> indice représentant le coup joué par le joueur
      - @enPause        ==> booleen indiquant vrai si la partie est en pause
      - @dernierIndice  ==> sauvegarde le dernier indice délivré
=end

class Partie
	@grilleEnCours
  @chronometre
  @tabCoup
  @indiceCoup
  @enPause
  @dernierIndice

  # Coding Assistant pour faciliter l'accès à la variable
  attr_accessor :grilleEnCours

  ##
  # Partie.creeToi:
  #   Cette méthode permet de créer une nouvelle partie
  def Partie.creeToi(uneGrille)
    new(uneGrille)
  end
  private_class_method :new

  attr :grilleEnCours, false
  # Coding Assistant pour faciliter l'accès à la variable
  attr :chronometre, true
  attr :tabCoup, false
  attr :indiceCoup, false
  attr :enPause, false
  attr :dernierIndice, true

  ##
  # initialize:
  #   Cette méthode est le constructeur, il permet d'initialiser tous les VI de la classe 
  #   sauf dernierIndice. Le constructeur créer un chronomêtre et associe la grille en paramêtre
  #   avec la variable grilleEnCours.
  def initialize(uneGrille)
    @grilleEnCours=uneGrille
    @tabCoup=Array.new()
    @indiceCoup=0
    @enPause=false
    @chronometre=Chronometre.creer()
  end

  ##
  # nouveauCoup:
  #   Cette méthode permet d'ajouter le coup passé en paramètre au tableau de coups et incrémente 
  #   l'indiceCoup.
  #
  #   @param unCoup représente le nouveau coup du Joueur.
  def nouveauCoup(unCoup)
    @tabCoup[@indiceCoup]=unCoup
    @indiceCoup+=1
  end

  ##
  # clicSurCase:
  #   Cette méthode permet de changer l'état de la case cliquée et créer un nouveau coup correspondant, 
  #   supprime les coups suivants.
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

  ##
  # undoPossible:
  #   Cette méthode permet de tester si l'undo est possible.
  #
  #   @return si le nomnbre de coup est plus grand que 0.
  def undoPossible?()
    return @indiceCoup>0
  end

  ##
  # redoPossible:
  #   Cette méthode permet de tester si le redo est possible.
  #
  #   @return s'il reste un coup dans le @tabCoup.
  def redoPossible?()
	   return @tabCoup[@indiceCoup].is_a?(Coup)
  end

  ##
  # redo:
  #   Cette méthode permet de retourner à l'état suivant.
  def redo()
    if(self.redoPossible?)
      @tabCoup[indiceCoup].case.etat=@tabCoup[indiceCoup].etat
      @indiceCoup+=1
    end
  end

  ##
  # raz:
  #   Cette méthode permet de réinitialiser les variables d'instance.
  def raz()
    @grilleEnCours.raz()
    @tabCoup=Array.new()
    @indiceCoup=0
    @enPause=false
    @chronometre=Chronometre.creer()
    @chronometre.metEnPause
  end

  ##
  # razSuirvie:
  #   Cette méthode permet de réinialiser les variables d'instance et 
  #   lui affecte un chronometre Survie.
  def razSurvie()
    @grilleEnCours.raz()
    @tabCoup=Array.new()
    @indiceCoup=0
    @enPause=false
    @chronometre=ChronometreSurvie.creer()
  end

  ##
  # partieFinie:
  #   Cette méthode permet tester si une partie est fini. 
  #
  #   @return si la partie est finie ou non.
  def partieFinie?()
    return @grilleEnCours.grilleFinie
  end

  ##
  # reviensALaBonnePosition:
  #   Cette méthode permet d'undo tant qu'il y a des erreurs.
  def reviensALaBonnePosition()
    while(@grilleEnCours.nbErreurs>0)
      self.undo
    end
  end

  ##
  # indice_ile1NonEntouree:
  #   Cette méthode permet de rechercher une case Ile de valeur 1 non entourée.
  #
  #   @return l'indice d'une case Ile de valeur 1 non entourée ou nil s'il n'y en a pas.
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

  ##
  # indice_IlesVoisinesNonSeparees:
  #   Cette méthode permet de rechercher une case jouable non jouée séparant deux cases îles.
  #
  #   @return l'indice d'une case jouable non jouée séparant deux cases îles ou nil s'il n'y en a pas.
  def indice_IlesVoisinesNonSeparees()
    for j in 0..@grilleEnCours.hauteur-1
      for i in 0..@grilleEnCours.largeur-1
        # On regarde si il existe deux cases îles séparées par une case jouable non jouée
        if @grilleEnCours.matriceCases[i][j].is_areéinitialiseeCases[i][j-1].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i][j-1].etat==0 && @grilleEnCours.matriceCases[i][j-2].is_a?(CaseNombre)
            return Indice.creer(:ilesVoisinesNonSeparees,[i,j-1])
          elsif i-2 >= 0 && @grilleEnCours.matriceCases[i-1][j].is_a?(CaseJouable) && @grilleEnCours.matriceCases[i-1][j].etat==0 && @grilleEnCours.matriceCases[i-2][j].is_a?(CaseNombre)
            return Indice.creer(:ilesVoisinesNonSeparees,[i-1,j])
          end
        end
      end
    end
    return nil
  end

  ##
  # indice_IlesDiagonalesNonSeparees:
  #   Cette méthode permet de rechercher une case jouable non jouée séparant deux cases îles en diagonales.
  #
  #   @return l'indice d'une case jouable non jouée séparant deux cases îles en diagonales ou nil s'il n'y en a pas.
  def indice_IlesDiagonalesNonSeparees()
    for j in 0..@grilleEnCours.hauteur-1
      for i in 0..@grilleEnCours.larg  Constants:   0 (0 undocumented)
        Attributes:  6 (5 undocumented)
        Methods:    21 (0 undocumented)
      
        Total:      28 (5 undocumented)
         82.14% documented
      
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

  ##
  # indice_Ocean2x2:
  #   Cette méthode permet de rechercher un carré de cases océan de taille 2x2.
  #
  #   @return l'indice d'un océan de cases de taille 2x2 ou nil s'il n'y en a pas.
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

  ##
  # indice_caseJouableIsolee:
  #   Cette méthode permet rechercher une case jouable, avec l'état non joué ou île, 
  #   entourée de cases océan ou des bords le la grille.
  #
  #   @return l'indice d'une case jouable avec l'état non joué ou île ou nil s'il n'y en a pas.
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

  ##
  # caseJouableAccessibleQueDUneDirection:
  #   Cette méthode permet de rechercher les coordonnées de la case adjacente à la case dont les coordonnées passées en paramètres, 
  #   si cette dernière n'est accessible que d'une seule case.
  #
  #   @param i représente la coordonnée en X de la case sélectionnée par le joueur.
  #   @param j représente la coordonnée en Y de la case sélectionnée par le joueur.
  #
  #   @return une case Jouable ou nil s'il n'y en a pas.
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

  ##
  # indice_expansionMur:
  #   Cette méthode permet de rechercher si un "mur" peut être étendu en mettant une case jouable à l'état océan. 
  #
  #   @return l'indice d'une case peut être un "mur" ou nil s'il n'y en a pas.
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

  ##
  # caseNombreAccessibleQueDUneDirection: 
  #   Cette méthode permet de rechercher les coordonnées de la case adjacente à la case dont les coordonnées passées en paramètres,
  #   si cette dernière n'est accessible que par une seule case.
  #
  #   @param i représente la coordonnée en X de la case sélectionnée par le joueur.
  #   @param y représente la coordonnée en Y de la case sélectionnée par le joueur.
  #
  #   @return une case Jouable ou nil s'il n'y en a pas.
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
  
  ##
  # indice_expansionIle:
  #   Cette méthode permet de rechercher si une île peut être étendue en mettant une case jouable à l'état île. 
  #
  #   @return l'indice d'île pouvant être étendue ou nil s'il n'y en a pas.
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
    
  ##
  # clicSurIndice:
  #   Cette méthode permet de chercher s'il y a un indice à donner à l'utilisateur 
  #   dans l'ordre du plus simple au plus complexe.
  #
  #   @return un indice si c'est possible ou nil au c'est impossible.
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
