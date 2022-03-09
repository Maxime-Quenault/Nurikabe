# On importe les librairies nécessaires au fonctionnement du programme
require "yaml.rb"
require 'gtk3'
include Gtk
load "Aventure.rb"
load "Partie.rb"
load "Chronometre.rb"
load "Grille.rb"

# Définition de la classe AffichageAventure qui affichera le mode Aventure
class AffichageAventure

  # Définition des constantes
  SEUIL_5_ETOILES = 1.0
  SEUIL_4_ETOILES = 1.20
  SEUIL_3_ETOILES = 1.40
  SEUIL_2_ETOILES = 2.0
  SEUIL_1_ETOILE = 2.20

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

  # Méthode qui ferme la fenêtre du mode Aventure
  def destruction
    Gtk.main_quit
    return
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

  # Méthode qui modifie l'image centrale à afficher
  # Dans notre cas on possède 2 images png :
  # => grilleVide que l'on affichera si la grille actuelle n'a pas été terminée
  # => grillePleine que l'on affichera si la grille actuelle a été terminée(peu importe le score)
  # Pas de miniature de la grille -> évite la triche
  def affichageImage
    if(@aventure.getEtoileCourante() == 0)
      Gtk::Image.gtk_image_set_from_file(@image,"../Image/grilleVide.png")
    else
      Gtk::Image.gtk_image_set_from_file(@image,"../Image/grillePleine.png")
    end
  end

  # Méthode qui gère l'affichage des étoiles de la grille actuelle
  # On prend en paramètre un nombre d'étoiles (correspond au score de la grille)
  # Puis on affiche autant d'étoile que le paramètre puis on complète le reste avec des étoiles noires
  def affichageEtoile(nbEtoiles)
    case nbEtoiles
    when 0
      imgEtoile1 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile2 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile3 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile4 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile5 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
    when 1
      imgEtoile1 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile2 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile3 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile4 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile5 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
    when 2
      imgEtoile1 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile2 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile3 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile4 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile5 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
    when 3
      imgEtoile1 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile2 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile3 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile4 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile5 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
    when 4
      imgEtoile1 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile2 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile3 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile4 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile5 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile_sombre.png")
    when 5
      imgEtoile1 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile2 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile3 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile4 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile5 = Gtk::Image.gtk_image_new_from_file ("../Image/etoile2.png")
    end
  end

  # Méthode qui gère la "surbrillance" des boutons Suivant et Précédent
  # Lorsque l'on clique sur l'un des boutons dans la barre en bas de la fenêtre
  # le bouton change de couleur pour indiquer que l'on se situe sur tel niveau.
  # Ainsi suivant la position du joueur(après le click sur suivant ou précédent)
  # On appel la méthode de "surbrillance" du bouton associé à notre position
  def boutonSuivPreced
    case(@aventure.getPosCourante())
    when 0
      @fenetre.pack_start(bouton1)
      break
    when 1
      @fenetre.pack_start(bouton2)
      break
    when 2
      @fenetre.pack_start(bouton3)
      break
    when 3
      @fenetre.pack_start(bouton4)
      break
    when 4
      @fenetre.pack_start(bouton5)
      break
    when 5
      @fenetre.pack_start(bouton6)
      break
    when 6
      @fenetre.pack_start(bouton7)
      break
    when 7
      @fenetre.pack_start(bouton8)
      break
    when 8
      @fenetre.pack_start(bouton9)
      break
    when 9
      @fenetre.pack_start(bouton10)
      break
    end
  end


  # Méthode d'affichage principale du mode Aventure qui sera appelé par les autres Classes
  def afficheToi
    @couleurBase = "white"
    @couleurVisible = "grey"

    # On attribue une image par défaut
    @image = Gtk::Image.new("../Image/grilleVide.png")

    # On créer un buildeur qui récupère les éléments de notre fenêtre créée sur Glade
    monBuildeur = Gtk::Builder.new()
    monBuildeur.add_from_file("../Modele_Image/aventure_normal_img.glade")

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

    # On déclare des objets que l'on associe aux éléments de la fenêtre Glade

    # Déclaration du bouton de retour situé dans le coin supérieur gauche de la fenetre
    retour = monBuildeur.get_object('btn_retour')

    # Déclaration des boutons de déplacement de la barre située en bas de fenêtre
    bouton1 = monBuildeur.get_object('btn_grille_1')
    bouton2 = monBuildeur.get_object('btn_grille_2')
    bouton3 = monBuildeur.get_object('btn_grille_3')
    bouton4 = monBuildeur.get_object('btn_grille_4')
    bouton5 = monBuildeur.get_object('btn_grille_5')
    bouton6 = monBuildeur.get_object('btn_grille_6')
    bouton7 = monBuildeur.get_object('btn_grille_7')
    bouton8 = monBuildeur.get_object('btn_grille_8')
    bouton9 = monBuildeur.get_object('btn_grille_9')
    bouton10 = monBuildeur.get_object('btn_grille_10')

    # Déclaration des boutons de changement de difficulté situés en haut de la fenêtre
    modeFacile = monBuildeur.get_object('btn_facile')
    modeNormal = monBuildeur.get_object('btn_normal')
    modeHard = monBuildeur.get_object('btn_difficile')

    # Déclaration des boutons de déplacement Suivant et Précédent situés sur les côtés de la fenêtre
    btnPreced = monBuildeur.get_object('btn_grille_preced')
    btnSuivant = monBuildeur.get_object('btn_grille_suiv')

    # Déclaration de l'image centrale de la fenêtre
    img_centre = monBuildeur.get_object('img_grille')

    # Déclaration des images étoiles qui seront liées au score de la grille actuelle
    imgEtoile1 = monBuildeur.get_object('etoile_1')
    imgEtoile2 = monBuildeur.get_object('etoile_2')
    imgEtoile3 = monBuildeur.get_object('etoile_3')
    imgEtoile4 = monBuildeur.get_object('etoile_4')
    imgEtoile5 = monBuildeur.get_object('etoile_5')

    # Déclaration de la fenêtre du mode Aventure
    fenetre = monBuilder.get_object('fenetre_aventure')

    # On associe le bouton Retour avec la méthode de fermeture du mode Aventure
    retour.signal_connect('clicked') {
      @fenetre.destruction()
    }

    @fenetre.signal_connect('destroy') {
      @fenetre.destruction()
    }

    # On associe le bouton Précédent avec la méthode grillePrecedente de la classe Aventure
    btnPreced.signal_connect('clicked') {
      @aventure.grillePrecedente()
      @fenetre.boutonSuivPreced()
    }

    # On associe le bouton Suivant avec la méthode prochaineGrille de la classe Aventure
    btnSuivant.signal_connect('clicked') {
      @aventure.prochaineGrille()
      @fenetre.boutonSuivPreced()
    }

    # On associe le bouton facile avec la méthode de choix de difficulté de la classe Aventure
    modeFacile.signal_connect('clicked') {
      @aventure.choixDifficulte(0)
      @aventure.placerSurGrille(0)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(modeFacile,@couleurVisible)
      @fenetre.setBackground(modeNormal,@couleurBase)
      @fenetre.setBackground(modeHard,@couleurBase)
    }

    # On associe le bouton normal avec la méthode de choix de difficulté de la classe Aventure
    modeNormal.signal_connect('clicked') {
      if(@aventure.unlockDifficulte())
        @aventure.choixDifficulte(1)
      end
      @aventure.placerSurGrille(0)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(modeFacile,@couleurBase)
      @fenetre.setBackground(modeNormal,@couleurVisible)
      @fenetre.setBackground(modeHard,@couleurBase)
    }

    # On associe le bouton difficile avec la méthode de choix de difficulté de la classe Aventure
    modeHard.signal_connect('clicked') {
      @aventure.choixDifficulte(1)
      if(@aventure.unlockDifficulte())
        @aventure.choixDifficulte(2)
      end
      @aventure.placerSurGrille(0)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(modeFacile,@couleurBase)
      @fenetre.setBackground(modeNormal,@couleurBase)
      @fenetre.setBackground(modeHard,@couleurVisible)
    }

    # On associe l'image de la grille avec la méthode de lancement de la Partie
    # + attribution des récompenses en fonction du timer
    img_centre.signal_connect('clicked') {

      chrono = Chronometre.creer(0,"+")
      # Ajouter méthode de lancement de la partie
      partie = Partie.creerToi(@aventure.getGrilleCourante)
      chrono.demarre()
      # + récupération du timer
      while(!partie.estFinie?());
      # Puis attribution du nombre d'étoiles en fonction du timer (à définir)

      temps = chrono.getTemps();

      case temps
      when temps <= SEUIL_5_ETOILES
        recompense = 5
      when temps <= SEUIL_4_ETOILES
        recompense = 4
      when temps <= SEUIL_3_ETOILES
        recompense = 3
      when temps <= SEUIL_2_ETOILES
        recompense = 2
      when temps <= SEUIL_1_ETOILES
        recompense = 1
      else
        recompense = 0
      end

      @aventure.setEtoileCourante(recompense)
      @aventure.etoilesEnPlus(recompense)
    }

    # On associe le bouton 1 de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    bouton1.signal_connect('clicked') {
      @aventure.placerSurGrille(0)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(bouton1,@couleurVisible)
      @fenetre.setBackground(bouton2,@couleurBase)
      @fenetre.setBackground(bouton3,@couleurBase)
      @fenetre.setBackground(bouton4,@couleurBase)
      @fenetre.setBackground(bouton5,@couleurBase)
      @fenetre.setBackground(bouton6,@couleurBase)
      @fenetre.setBackground(bouton7,@couleurBase)
      @fenetre.setBackground(bouton8,@couleurBase)
      @fenetre.setBackground(bouton9,@couleurBase)
      @fenetre.setBackground(bouton10,@couleurBase)
    }

    # On associe le bouton 2 de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    bouton2.signal_connect('clicked') {
      @aventure.placerSurGrille(1)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(bouton1,@couleurBase)
      @fenetre.setBackground(bouton2,@couleurVisible)
      @fenetre.setBackground(bouton3,@couleurBase)
      @fenetre.setBackground(bouton4,@couleurBase)
      @fenetre.setBackground(bouton5,@couleurBase)
      @fenetre.setBackground(bouton6,@couleurBase)
      @fenetre.setBackground(bouton7,@couleurBase)
      @fenetre.setBackground(bouton8,@couleurBase)
      @fenetre.setBackground(bouton9,@couleurBase)
      @fenetre.setBackground(bouton10,@couleurBase)
    }

    # On associe le bouton 3 de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    bouton3.signal_connect('clicked') {
      @aventure.placerSurGrille(2)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(bouton1,@couleurBase)
      @fenetre.setBackground(bouton2,@couleurBase)
      @fenetre.setBackground(bouton3,@couleurVisible)
      @fenetre.setBackground(bouton4,@couleurBase)
      @fenetre.setBackground(bouton5,@couleurBase)
      @fenetre.setBackground(bouton6,@couleurBase)
      @fenetre.setBackground(bouton7,@couleurBase)
      @fenetre.setBackground(bouton8,@couleurBase)
      @fenetre.setBackground(bouton9,@couleurBase)
      @fenetre.setBackground(bouton10,@couleurBase)
    }

    # On associe le bouton 4 de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    bouton4.signal_connect('clicked') {
      @aventure.placerSurGrille(3)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(bouton1,@couleurBase)
      @fenetre.setBackground(bouton2,@couleurBase)
      @fenetre.setBackground(bouton3,@couleurBase)
      @fenetre.setBackground(bouton4,@couleurVisible)
      @fenetre.setBackground(bouton5,@couleurBase)
      @fenetre.setBackground(bouton6,@couleurBase)
      @fenetre.setBackground(bouton7,@couleurBase)
      @fenetre.setBackground(bouton8,@couleurBase)
      @fenetre.setBackground(bouton9,@couleurBase)
      @fenetre.setBackground(bouton10,@couleurBase)
    }

    # On associe le bouton 5 de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    bouton5.signal_connect('clicked') {
      @aventure.placerSurGrille(4)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(bouton1,@couleurBase)
      @fenetre.setBackground(bouton2,@couleurBase)
      @fenetre.setBackground(bouton3,@couleurBase)
      @fenetre.setBackground(bouton4,@couleurBase)
      @fenetre.setBackground(bouton5,@couleurVisible)
      @fenetre.setBackground(bouton6,@couleurBase)
      @fenetre.setBackground(bouton7,@couleurBase)
      @fenetre.setBackground(bouton8,@couleurBase)
      @fenetre.setBackground(bouton9,@couleurBase)
      @fenetre.setBackground(bouton10,@couleurBase)
    }

    # On associe le bouton 6 de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    bouton6.signal_connect('clicked') {
      @aventure.placerSurGrille(5)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(bouton1,@couleurBase)
      @fenetre.setBackground(bouton2,@couleurBase)
      @fenetre.setBackground(bouton3,@couleurBase)
      @fenetre.setBackground(bouton4,@couleurBase)
      @fenetre.setBackground(bouton5,@couleurBase)
      @fenetre.setBackground(bouton6,@couleurVisible)
      @fenetre.setBackground(bouton7,@couleurBase)
      @fenetre.setBackground(bouton8,@couleurBase)
      @fenetre.setBackground(bouton9,@couleurBase)
      @fenetre.setBackground(bouton10,@couleurBase)
    }

    # On associe le bouton 7 de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    bouton7.signal_connect('clicked') {
      @aventure.placerSurGrille(6)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(bouton1,@couleurBase)
      @fenetre.setBackground(bouton2,@couleurBase)
      @fenetre.setBackground(bouton3,@couleurBase)
      @fenetre.setBackground(bouton4,@couleurBase)
      @fenetre.setBackground(bouton5,@couleurBase)
      @fenetre.setBackground(bouton6,@couleurBase)
      @fenetre.setBackground(bouton7,@couleurVisible)
      @fenetre.setBackground(bouton8,@couleurBase)
      @fenetre.setBackground(bouton9,@couleurBase)
      @fenetre.setBackground(bouton10,@couleurBase)
    }

    # On associe le bouton 8 de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    bouton8.signal_connect('clicked') {
      @aventure.placerSurGrille(7)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(bouton1,@couleurBase)
      @fenetre.setBackground(bouton2,@couleurBase)
      @fenetre.setBackground(bouton3,@couleurBase)
      @fenetre.setBackground(bouton4,@couleurBase)
      @fenetre.setBackground(bouton5,@couleurBase)
      @fenetre.setBackground(bouton6,@couleurBase)
      @fenetre.setBackground(bouton7,@couleurBase)
      @fenetre.setBackground(bouton8,@couleurVisible)
      @fenetre.setBackground(bouton9,@couleurBase)
      @fenetre.setBackground(bouton10,@couleurBase)
    }

    # On associe le bouton 9 de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    bouton9.signal_connect('clicked') {
      @aventure.placerSurGrille(8)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(bouton1,@couleurBase)
      @fenetre.setBackground(bouton2,@couleurBase)
      @fenetre.setBackground(bouton3,@couleurBase)
      @fenetre.setBackground(bouton4,@couleurBase)
      @fenetre.setBackground(bouton5,@couleurBase)
      @fenetre.setBackground(bouton6,@couleurBase)
      @fenetre.setBackground(bouton7,@couleurBase)
      @fenetre.setBackground(bouton8,@couleurBase)
      @fenetre.setBackground(bouton9,@couleurVisible)
      @fenetre.setBackground(bouton10,@couleurBase)
    }

    # On associe le bouton 10 de la barre de déplacement avec la méthode de déplacement sur Grille de la classe Aventure
    bouton10.signal_connect('clicked') {
      @aventure.placerSurGrille(9)
      @fenetre.affichageEtoile(@aventure.getEtoileCourante())
      @fenetre.affichageImage()
      @fenetre.setBackground(bouton1,@couleurBase)
      @fenetre.setBackground(bouton2,@couleurBase)
      @fenetre.setBackground(bouton3,@couleurBase)
      @fenetre.setBackground(bouton4,@couleurBase)
      @fenetre.setBackground(bouton5,@couleurBase)
      @fenetre.setBackground(bouton6,@couleurBase)
      @fenetre.setBackground(bouton7,@couleurBase)
      @fenetre.setBackground(bouton8,@couleurBase)
      @fenetre.setBackground(bouton9,@couleurBase)
      @fenetre.setBackground(bouton10,@couleurVisible)
    }

    @fenetre.show_all

    Gtk.main

  end

end