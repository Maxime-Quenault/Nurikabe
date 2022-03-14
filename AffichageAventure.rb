# On importe les librairies nécessaires au fonctionnement du programme
require "yaml.rb"
require 'gtk3'
include Gtk
load "Aventure/Aventure.rb"
load "Partie/Partie.rb"
load "Partie/Chronometre.rb"
load "Partie/Grille.rb"

# Définition de la classe AffichageAventure qui affichera le mode Aventure
class AffichageAventure

  # Définition des constantes
  SEUIL_5_ETOILES = 1.0
  SEUIL_4_ETOILES = 1.20
  SEUIL_3_ETOILES = 1.40
  SEUIL_2_ETOILES = 2.0
  SEUIL_1_ETOILE = 2.20

  # Déclaration des VI liées aux couleurs de l'interface
  # Variable d'instance qui représente la couleur de la fenêtre
  @couleurFenetre
  # Variable d'instance qui représente la couleur générale de la fenêtre(thème)
  @couleurBase
  # Variable d'instance qui représente la couleur secondaire qui ressort de la couleur générale(thème)
  @couleurVisible

  # Variable d'instance qui contient une image png qui variera selon les grilles
  @image
  # Variable d'instance qui contiendra la fenêtre de l'interface glade
  @fenetre
  # Variable d'instance qui contient l'aventure en cours
  @aventure

  # Variable d'instance liée au temps de complétion de la grille
  @tempsGrille

  # Variable d'instance liée aux images des étoiles -> afin d'être connu de toutes les méthodes
  @imgEtoile

  # Variable d'instance liée aux boutons de la barre de déplacement -> afin d'être connu de toutes les méthodes
  @bouton

  def initialize(unObjet)

    @couleurBase = "white"
    @couleurVisible = "grey"

    # On créer 3 objets aventures plus un autre qui manipulera les références des autres
    # Création des 3 aventures : Facile , Normale , Difficile avec générations des niveaux
    aventureFacile = Aventure.creer(0)
    aventureFacile.generationAventure(10)

    aventureNormale = Aventure.creer(1)
    aventureNormale.generationAventure(10)

    aventureDifficile = Aventure.creer(2)
    aventureDifficile.generationAventure(10)

    # On édite les liens entre les 3 aventures
    aventureFacile.setPrecedent(nil)
    aventureFacile.setSuivant(aventureNormale)

    aventureNormale.setPrecedent(aventureFacile)
    aventureNormale.setSuivant(aventureDifficile)

    aventureDifficile.setPrecedent(aventureNormale)
    aventureDifficile.setSuivant(nil)

    @aventure = aventureFacile

    # On attribue une image par défaut
    @image = Gtk::Image.new("Image/grilleVide.png")

    # On créer un buildeur qui récupère les éléments de notre fenêtre créée sur Glade
    #monBuildeur = Gtk::Builder.new()
    #monBuildeur.add_from_file("glade/aventure_normal_img.glade")
    monBuildeur = Gtk::Builder.new(:file => 'glade/aventure_normal_img.glade')

    # On déclare des objets que l'on associe aux éléments de la fenêt1,8,6re Glade

    # Déclaration du bouton de retour situé dans le coin supérieur gauche de la fenetre
    @retour = monBuildeur.get_object('btn_retour')

    # Déclaration des boutons de déplacement de la barre située en bas de fenêtre
    @bouton = Array.new()
    @bouton[0] = monBuildeur.get_object('btn_grille_1')
    @bouton[1] = monBuildeur.get_object('btn_grille_2')
    @bouton[2] = monBuildeur.get_object('btn_grille_3')
    @bouton[3] = monBuildeur.get_object('btn_grille_4')
    @bouton[4] = monBuildeur.get_object('btn_grille_5')
    @bouton[5] = monBuildeur.get_object('btn_grille_6')
    @bouton[6] = monBuildeur.get_object('btn_grille_7')
    @bouton[7] = monBuildeur.get_object('btn_grille_8')
    @bouton[8] = monBuildeur.get_object('btn_grille_9')
    @bouton[9] = monBuildeur.get_object('btn_grille_10')

    # Déclaration des boutons de changement de difficulté situés en haut de la fenêtre
    @modeFacile = monBuildeur.get_object('btn_facile')
    @modeNormal = monBuildeur.get_object('btn_normal')
    @modeHard = monBuildeur.get_object('btn_difficile')

    # Déclaration des boutons de déplacement Suivant et Précédent situés sur les côtés de la fenêtre
    @btnPreced = monBuildeur.get_object('btn_grille_preced')
    @btnSuivant = monBuildeur.get_object('btn_grille_suiv')

    # Déclaration de l'image centrale de la fenêtre
    @img_centre = monBuildeur.get_object('img_grille')

    # Déclaration de l'affichage du temps
    @tempsGrille = monBuildeur.get_object('temps_score')

    # Déclaration des images étoiles qui seront liées au score de la grille actuelle
    @imgEtoile = Array.new()
    @imgEtoile[0] = monBuildeur.get_object('etoile_1')
    @imgEtoile[1] = monBuildeur.get_object('etoile_2')
    @imgEtoile[2] = monBuildeur.get_object('etoile_3')
    @imgEtoile[3] = monBuildeur.get_object('etoile_4')
    @imgEtoile[4] = monBuildeur.get_object('etoile_5')

    # Déclaration de la fenêtre du mode Aventure
    @fenetre = monBuildeur.get_object('fenetre_aventure')
    @interfaceGrille = FenetreGrille.new(@fenetre)

  end

  ################### Méthodes d'accès en lecture/éciture  ###################

  # Méthode d'accès en lecture de la couleur de la fenêtre
  def getCouleurFenetre
    return @couleurFenetre
  end

  # Méthode d'accès en écriture de la couleur de la fenêtre
  def setCouleurFenetre(uneCouleur)
    @couleurFenetre = uneCouleur
    Gtk.gtk_widget_modify_bg(@fenetre, GTK_STATE_NORMAL, @couleurFenetre);
  end

  # Méthode d'accès en lecture de la couleur générale de la fenêtre
  def getCouleurGeneral
    return @couleurBase
  end

  # Méthode d'accès en écriture de la couleur générale de la fenêtre
  def setCouleurGeneral(couleur)
    @couleurBase = couleur
  end

  # Méthode d'accès en lecture de la couleur secondaire de la fenêtre
  def getCouleurSecondaire
    return @couleurVisible
  end

  # Méthode d'accès en écriture de la couleur secondaire de la fenêtre
  def setCouleurSecondaire(couleur)
    @couleurVisible = couleur
  end

  # Méthode qui prend en paramètre un bouton et une couleur : on applique cette couleur au bouton désigné
  def setBackground(bouton, couleur)
    bouton.bg = couleur
  end

  # Méthode qui prend en paramètre un bouton et une couleur : on applique cette couleur au bouton désigné
  def setBackgroundBoutons(indice, couleurUnique, couleurStandard)
    for i in 0...@bouton.length()
      if(i == indice)
        @bouton[i].bg = couleurUnique
      else
        @bouton[i].bg = couleurStandard
      end
  end

  def setEffetBouton(indice)
    @aventure.placerSurGrille(indice)
    @fenetre.affichageEtoile(@aventure.getEtoileCourante())
    @fenetre.affichageTemps()
    @fenetre.affichageImageGrille()
    @fenetre.setBackgroundBoutons(indice, @couleurVisible, @couleurBase)
  end

  ################### Méthodes liées aux affichages et évènements  ###################

  # Méthode qui ferme la fenêtre du mode Aventure
  def destruction
    Gtk.main_quit
    return
  end

  # Méthode qui modifie l'affichage du temps de la grille
  def affichageTemps
    Gtk.gtk_label_set(@tempsGrille,@aventure.getTempsCourant())
  end

  # Méthode qui modifie l'image centrale à afficher
  # Dans notre cas on possède 2 images png :
  # => grilleVide que l'on affichera si la grille actuelle n'a pas été terminée
  # => grillePleine que l'on affichera si la grille actuelle a été terminée(peu importe le score)
  # Pas de miniature de la grille -> évite la triche
  def affichageImageGrille
    if(@aventure.getEtoileCourante() == 0)
      Gtk::Image.set_from_file(@image,"Image/grilleVide.png")
    else
      Gtk::Image.set_from_file(@image,"Image/grillePleine.png")
    end
  end

  # Méthode qui gère l'affichage des étoiles de la grille actuelle
  # On prend en paramètre un nombre d'étoiles (correspond au score de la grille)
  # Puis on affiche autant d'étoile que le paramètre puis on complète le reste avec des étoiles noires
  def affichageEtoile(nbEtoiles)

    case nbEtoiles
    when 0
      Gtk::Image.set_from_file(@imgEtoile[0],"Image/etoile_sombre.png")
      Gtk::Image.set_from_file(@imgEtoile[1],"Image/etoile_sombre.png")
      Gtk::Image.set_from_file(@imgEtoile[2],"Image/etoile_sombre.png")
      Gtk::Image.set_from_file(@imgEtoile[3],"Image/etoile_sombre.png")
      Gtk::Image.set_from_file(@imgEtoile[4],"Image/etoile_sombre.png")
    when 1
      Gtk::Image.set_from_file(@imgEtoile[0],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[1],"Image/etoile_sombre.png")
      Gtk::Image.set_from_file(@imgEtoile[2],"Image/etoile_sombre.png")
      Gtk::Image.set_from_file(@imgEtoile[3],"Image/etoile_sombre.png")
      Gtk::Image.set_from_file(@imgEtoile[4],"Image/etoile_sombre.png")
    when 2
      Gtk::Image.set_from_file(@imgEtoile[0],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[1],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[2],"Image/etoile_sombre.png")
      Gtk::Image.set_from_file(@imgEtoile[3],"Image/etoile_sombre.png")
      Gtk::Image.set_from_file(@imgEtoile[4],"Image/etoile_sombre.png")
    when 3
      Gtk::Image.set_from_file(@imgEtoile[0],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[1],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[2],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[3],"Image/etoile_sombre.png")
      Gtk::Image.set_from_file(@imgEtoile[4],"Image/etoile_sombre.png")
    when 4
      Gtk::Image.set_from_file(@imgEtoile[0],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[1],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[2],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[3],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[4],"Image/etoile_sombre.png")
    when 5
      Gtk::Image.set_from_file(@imgEtoile[0],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[1],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[2],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[3],"Image/etoile2.png")
      Gtk::Image.set_from_file(@imgEtoile[4],"Image/etoile2.png")
    end

  end

  # Méthode qui gère la "surbrillance" des boutons Suivant et Précédent
  # Lorsque l'on clique sur l'un des boutons dans la barre en bas de la fenêtre
  # le bouton change de couleur pour indiquer que l'on se situe sur tel niveau.
  # Ainsi suivant la position du joueur(après le click sur suivant ou précédent)
  # On appel la méthode de "surbrillance" du bouton associé à notre position
  def boutonSuivPreced
      @fenetre.pack_start(@bouton[@aventure.getPosCourante()])
  end

  ################### Méthode principale - afficheToi  ###################

  # Méthode d'affichage principale du mode Aventure qui sera appelé par les autres Classes
  def afficheToi

    # On associe le bouton Retour avec la méthode de fermeture du mode Aventure
    @retour.signal_connect('clicked'){
      @fenetre.destruction()
    }

    @fenetre.signal_connect('destroy'){
      @fenetre.destruction()
    }

    # On associe le bouton Précédent avec la méthode grillePrecedente de la classe Aventure
    @btnPreced.signal_connect('clicked'){
      @aventure.grillePrecedente()
      @fenetre.boutonSuivPreced()
    }

    # On associe le bouton Suivant avec la méthode prochaineGrille de la classe Aventure
    @btnSuivant.signal_connect('clicked'){
      @aventure.prochaineGrille()
      @fenetre.boutonSuivPreced()
    }

    # On associe le bouton facile avec la méthode de choix de difficulté de la classe Aventure
    @modeFacile.signal_connect('clicked'){
      @aventure.choixDifficulte(0)
      @aventure.placerSurGrille(0)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageTemps()
      @fenetre.affichageImageGrille()
      @fenetre.setBackground(@modeFacile,@couleurVisible)
      @fenetre.setBackground(@modeNormal,@couleurBase)
      @fenetre.setBackground(@modeHard,@couleurBase)
    }

    # On associe le bouton normal avec la méthode de choix de difficulté de la classe Aventure
    @modeNormal.signal_connect('clicked'){
      if(@aventure.unlockDifficulte())
        @aventure.choixDifficulte(1)
      end
      @aventure.placerSurGrille(0)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageTemps()
      @fenetre.affichageImageGrille()
      @fenetre.setBackground(@modeFacile,@couleurBase)
      @fenetre.setBackground(@modeNormal,@couleurVisible)
      @fenetre.setBackground(@modeHard,@couleurBase)
    }

    # On associe le bouton difficile avec la méthode de choix de difficulté de la classe Aventure
    @modeHard.signal_connect('clicked'){
      @aventure.choixDifficulte(1)
      if(@aventure.unlockDifficulte())
        @aventure.choixDifficulte(2)
      end
      @aventure.placerSurGrille(0)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageTemps()
      @fenetre.affichageImageGrille()
      @fenetre.setBackground(@modeFacile,@couleurBase)
      @fenetre.setBackground(@modeNormal,@couleurBase)
      @fenetre.setBackground(@modeHard,@couleurVisible)
    }

    # On associe l'image de la grille avec la méthode de lancement de la Partie
    # + attribution des récompenses en fonction du timer
    @img_centre.signal_connect('clicked'){

      # Pour la création du chronomètre le deuxième paramètre est censé être le sens du timer
      # -> dans Chronometre.rb il n'est pas précisé la valeur attendu pour la création d'un timer ascendant
      # Par défaut j'ai mis "1" si ce n'est pas le cas alors il faudra moidifier
      chrono = Chronometre.creer(0,1)
      # Ajouter méthode de lancement de la partie
      partie = Partie.creerToi(@aventure.getGrilleCourante())
      chrono.demarre()
      # + récupération du timer
      #while(!partie.estFinie?())
      #end
      @interfaceGrille.construction
      self.changerInterface(@interfaceGrille.object, "Partie")
      # Puis attribution du nombre d'étoiles en fonction du timer (à définir)
      chrono.metEnPause()
      temps = chrono.getTemps()

      case temps
      when temps <= SEUIL_5_ETOILES
        recompense = 5
      when temps <= SEUIL_4_ETOILES
        recompense = 4
      when temps <= SEUIL_3_ETOILES
        recompense = 3
      when temps <= SEUIL_2_ETOILES
        recompense = 2
      when temps <= SEUIL_1_ETOILE
        recompense = 1
      else
        recompense = 0
      end

      @aventure.setEtoileCourante(recompense)
      @aventure.etoilesEnPlus(recompense)
      @aventure.setTempsCourant(temps)
    }

    # On associe chaque boutons de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    for i in 0...@bouton.length()
      @bouton[i].signal_connect('clicked'){
        self.setEffetBouton(i)
      }
    end

    @fenetre.show_all()

    Gtk.main()

  end

end
