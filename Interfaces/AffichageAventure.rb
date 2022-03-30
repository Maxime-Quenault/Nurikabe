# On importe les librairies nécessaires au fonctionnement du programme
require "yaml.rb"
require 'gtk3'
require 'date'
include Gtk

load "Aventure/Aventure.rb"
load "Partie/Partie.rb"
load "Partie/Chronometre.rb"
load "Partie/Grille.rb"

load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"
load "Interfaces/Fenetre.rb"
load "Interfaces/FenetreGrille.rb"

# Définition de la classe AffichageAventure qui affichera le mode Aventure
class AffichageAventure < Fenetre

  # Définition des constantes
  SEUIL_5_ETOILES = 60.00
  SEUIL_4_ETOILES = 80.00
  SEUIL_3_ETOILES = 100.00
  SEUIL_2_ETOILES = 120.00
  SEUIL_1_ETOILE = 140.00

  FACILE = 0
	MOYEN = 1
	DIFFICILE = 2

  #################### Déclaration des VI
  #
  # @couleurFenetre : Variable d'instance qui représente la couleur de la fenêtre
  #
  # @couleurBase : Variable d'instance qui représente la couleur générale de la fenêtre(thème)
  #
  # @couleurVisible : Variable d'instance qui représente la couleur secondaire qui ressort de la couleur générale(thème)
  #
  # @img_centre : Variable d'instance qui contient une image png qui variera selon les grilles
  #
  # @fenetre : Variable d'instance qui contiendra la fenêtre de l'interface glade
  #
  # @aventure : Variable d'instance qui contient l'aventure en cours
  #
  # @tempsGrille : Variable d'instance liée au temps de complétion de la grille
  #
  # @imgEtoile : Variable d'instance liée aux images des étoiles -> afin d'être connu de toutes les méthodes
  #
  # @bouton : Variable d'instance liée aux boutons de la barre de déplacement -> afin d'être connu de toutes les méthodes
  #
  # @menuParent : Variable d'instance qui contient l'interface parent transmise lors la création de celle-ci
  #
  # @interfaceGrille : Variable d'instance qui contient le lien vers une fenêtre de grille avec laquelle l'utilisateur pourra intéragir
  #
  ####################

  attr_accessor :fenetre, :menuParent, :interfaceGrille

  def initialize(menuParent)

    @couleurBase = "white"
    @couleurVisible = "grey"

    # On créer 3 objets aventures plus un autre qui manipulera les références des autres
    # Création des 3 aventures : Facile , Normale , Difficile avec générations des niveaux
    aventureFacile = Aventure.creer(0)
    aventureFacile.generationAventure(10,FACILE)

    aventureNormale = Aventure.creer(1)
    aventureNormale.generationAventure(10,MOYEN)

    aventureDifficile = Aventure.creer(2)
    aventureDifficile.generationAventure(10,DIFFICILE)

    # On édite les liens entre les 3 aventures
    aventureFacile.setPrecedent(nil)
    aventureFacile.setSuivant(aventureNormale)

    aventureNormale.setPrecedent(aventureFacile)
    aventureNormale.setSuivant(aventureDifficile)

    aventureDifficile.setPrecedent(aventureNormale)
    aventureDifficile.setSuivant(nil)

    @aventure = aventureFacile

    # On créer un buildeur qui récupère les éléments de notre fenêtre créée sur Glade
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
    @btn_img = monBuildeur.get_object('btn_img')
    # Déclaration de l'affichage du temps
    @tempsGrille = monBuildeur.get_object('temps_score')

    # Déclaration des images étoiles qui seront liées au score de la grille actuelle
    @imgEtoile = Array.new()
    @imgEtoile[0] = monBuildeur.get_object('etoile_1')
    @imgEtoile[1] = monBuildeur.get_object('etoile_2')
    @imgEtoile[2] = monBuildeur.get_object('etoile_3')
    @imgEtoile[3] = monBuildeur.get_object('etoile_4')
    @imgEtoile[4] = monBuildeur.get_object('etoile_5')

    # on sauvegarde le menu parent via une variable d'instance
    @menuParent = menuParent
    # Déclaration de la fenêtre du mode Aventure
    @fenetre = monBuildeur.get_object('fenetre_aventure')
    # on prépare une interface FenetreGrille que l'on appellera quand on en aura besoin
    @interfaceGrille = FenetreGrille.new(@fenetre)

    self.gestionSignaux

  end

  ################### Méthodes d'accès en lecture/éciture  ###################

  ##
	# getObjet :
	# 	Cette methode permet d'envoyer sont objet (interface) a l'objet qui le demande.
	#
	# @return object qui represente l'interface de la fenetre du mode libre.
	def getObject
		return @fenetre
	end

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
  end

  def setEffetBouton(indice)
    @aventure.placerSurGrille(indice)
    self.affichageEtoile(@aventure.getEtoileCourante())
    self.affichageTemps()
    self.affichageImageGrille()
  end

  ################### Méthodes liées aux affichages et évènements  ###################

  # Méthode qui ferme la fenêtre du mode Aventure
  def destruction
    Gtk.main_quit
    return
  end

  def affichageNewDiff(unNumero)
   dialog = Gtk::Dialog.new()
   dialog.title = "Nouvelle Difficulté"
   dialog.set_default_size(300, 100)
   case unNumero
   when 0
     dialog.child.add(Gtk::Label.new("\nTu ne possèdes pas assez d'étoiles pour débloquer cette difficulté...\nRefais d'autres niveaux."))
   when 1
     dialog.child.add(Gtk::Label.new("\nBravo tu viens de débloquer la difficulté Normal !"))
   when 2
     dialog.child.add(Gtk::Label.new("\nBravo tu viens de débloquer la difficulté Hard !"))
   end
   dialog.add_button(Gtk::Stock::CLOSE, Gtk::ResponseType::CLOSE)
   dialog.set_default_response(Gtk::ResponseType::CANCEL)

   dialog.signal_connect("response") do |widget, response|
       case response
       when Gtk::ResponseType::CANCEL
       p "Cancel"
       when Gtk::ResponseType::CLOSE
       p "Close"
       dialog.destroy
       end
   end
   dialog.show_all
  end

  # Méthode qui modifie l'affichage du temps de la grille
  def affichageTemps
    @tempsGrille.set_text("#{@aventure.getTempsCourant()}")
  end

  # Méthode qui modifie l'image centrale à afficher
  # Dans notre cas on possède 2 images png :
  # => grilleVide que l'on affichera si la grille actuelle n'a pas été terminée
  # => grillePleine que l'on affichera si la grille actuelle a été terminée(peu importe le score)
  # Pas de miniature de la grille -> évite la triche
  def affichageImageGrille
    if(@aventure.getEtoileCourante() == 0)
      @img_centre.set_from_file("Image/grilleVide.png")
    else
      @img_centre.set_from_file("Image/grillePleine.png")
    end
  end

  # Méthode qui gère l'affichage des étoiles de la grille actuelle
  # On prend en paramètre un nombre d'étoiles (correspond au score de la grille)
  # Puis on affiche autant d'étoile que le paramètre puis on complète le reste avec des étoiles noires
  def affichageEtoile(nbEtoiles)

    case nbEtoiles
    when 0
      @imgEtoile[0].set_from_file("Image/etoile_sombre.png")
      @imgEtoile[1].set_from_file("Image/etoile_sombre.png")
      @imgEtoile[2].set_from_file("Image/etoile_sombre.png")
      @imgEtoile[3].set_from_file("Image/etoile_sombre.png")
      @imgEtoile[4].set_from_file("Image/etoile_sombre.png")
    when 1
      @imgEtoile[0].set_from_file("Image/etoile2.png")
      @imgEtoile[1].set_from_file("Image/etoile_sombre.png")
      @imgEtoile[2].set_from_file("Image/etoile_sombre.png")
      @imgEtoile[3].set_from_file("Image/etoile_sombre.png")
      @imgEtoile[4].set_from_file("Image/etoile_sombre.png")
    when 2
      @imgEtoile[0].set_from_file("Image/etoile2.png")
      @imgEtoile[1].set_from_file("Image/etoile2.png")
      @imgEtoile[2].set_from_file("Image/etoile_sombre.png")
      @imgEtoile[3].set_from_file("Image/etoile_sombre.png")
      @imgEtoile[4].set_from_file("Image/etoile_sombre.png")
    when 3
      @imgEtoile[0].set_from_file("Image/etoile2.png")
      @imgEtoile[1].set_from_file("Image/etoile2.png")
      @imgEtoile[2].set_from_file("Image/etoile2.png")
      @imgEtoile[3].set_from_file("Image/etoile_sombre.png")
      @imgEtoile[4].set_from_file("Image/etoile_sombre.png")
    when 4
      @imgEtoile[0].set_from_file("Image/etoile2.png")
      @imgEtoile[1].set_from_file("Image/etoile2.png")
      @imgEtoile[2].set_from_file("Image/etoile2.png")
      @imgEtoile[3].set_from_file("Image/etoile2.png")
      @imgEtoile[4].set_from_file("Image/etoile_sombre.png")
    when 5
      @imgEtoile[0].set_from_file("Image/etoile2.png")
      @imgEtoile[1].set_from_file("Image/etoile2.png")
      @imgEtoile[2].set_from_file("Image/etoile2.png")
      @imgEtoile[3].set_from_file("Image/etoile2.png")
      @imgEtoile[4].set_from_file("Image/etoile2.png")
    end

  end

  # Méthode qui gère la "surbrillance" des boutons Suivant et Précédent
  # Lorsque l'on clique sur l'un des boutons dans la barre en bas de la fenêtre
  # le bouton change de couleur pour indiquer que l'on se situe sur tel niveau.
  # Ainsi suivant la position du joueur(après le click sur suivant ou précédent)
  # On appel la méthode de "surbrillance" du bouton associé à notre position
  def boutonSuiv
      @aventure.prochaineGrille()
      self.affichageEtoile(@aventure.getEtoileCourante())
      self.affichageTemps()
      self.affichageImageGrille()
  end

  def boutonPreced
      #self.pack_start(@fenetre,@bouton[@aventure.getPosCourante()],false,false,nil)
      @aventure.grillePrecedente()
      self.affichageEtoile(@aventure.getEtoileCourante())
      self.affichageTemps()
      self.affichageImageGrille()
  end

  def deplacementAventure(uneDiff)
    if(@aventure.getDifficulte < uneDiff)
      while(@aventure.getDifficulte < uneDiff)
        @aventure.difficultePrecedente
      end
    else
      if(@aventure.getDifficulte < uneDiff)
        while(@aventure.getDifficulte < uneDiff)
          @aventure.difficulteSuivante
        end
      end
    end
  end

  ################### Méthode principale - gestionSignaux  ###################

  # Méthode d'affichage principale du mode Aventure qui sera appelé par les autres Classes
  def gestionSignaux

    # On associe le bouton Retour avec la méthode de fermeture du mode Aventure
    @retour.signal_connect('clicked'){
      self.changerInterface(@menuParent, "Menu")
    }

    @fenetre.signal_connect('destroy'){
      self.destruction()
    }

    # On associe le bouton Précédent avec la méthode grillePrecedente de la classe Aventure
    @btnPreced.signal_connect('clicked'){
      self.boutonPreced()
      print "\n #{@aventure.getPosCourante}"
    }

    # On associe le bouton Suivant avec la méthode prochaineGrille de la classe Aventure
    @btnSuivant.signal_connect('clicked'){
      self.boutonSuiv()
      print "\n #{@aventure.getPosCourante}"
    }

    # On associe le bouton facile avec la méthode de choix de difficulté de la classe Aventure
    @modeFacile.signal_connect('clicked'){
      @aventure.choixDifficulte(0)
      @aventure.placerSurGrille(0)
      self.affichageEtoile(@aventure.getEtoileCourante())
      self.affichageTemps()
      self.affichageImageGrille()
      print "\n #{@aventure.difficulte}"
    }

    # On associe le bouton normal avec la méthode de choix de difficulté de la classe Aventure
    @modeNormal.signal_connect('clicked'){
      if(!@aventure.estDebloquee(1))
        self.affichageNewDiff(@aventure.unlockDifficulte())
      end

      if(@aventure.estDebloquee(1))

        if(@aventure.choixDifficulte(1))
          self.deplacementAventure(1)
        end

        @aventure.placerSurGrille(0)
        self.affichageEtoile(@aventure.getEtoileCourante())
        self.affichageTemps()
        self.affichageImageGrille()
      end

      print "\n #{@aventure.difficulte}"
    }

    # On associe le bouton difficile avec la méthode de choix de difficulté de la classe Aventure
    @modeHard.signal_connect('clicked'){
      if(!@aventure.estDebloquee(2))
        self.affichageNewDiff(@aventure.unlockDifficulte())
      end

      if(@aventure.estDebloquee(2))

        if(@aventure.choixDifficulte(2))
          self.deplacementAventure(2)
        end

        @aventure.choixDifficulte(2)
        @aventure.placerSurGrille(0)
        self.affichageEtoile(@aventure.getEtoileCourante())
        self.affichageTemps()
        self.affichageImageGrille()
      end

      print "\n #{@aventure.difficulte}"
    }

    # On associe l'image de la grille avec la méthode de lancement de la Partie
    # + attribution des récompenses en fonction du timer
    @btn_img.signal_connect('clicked'){

      temps1 = (Time.now.to_f * 1000)
      @@partie = Partie.creeToi(@aventure.getGrilleCourante())

      @interfaceGrille.construction
      self.changerInterface(@interfaceGrille.object, "Partie")

      print("\n #{@aventure.getGrilleCourante().pourcentageCompletion()}")

      temps2 = (Time.now.to_f * 1000) - temps1
      temps = temps2.round(2)

      if(@aventure.getGrilleCourante().pourcentageCompletion() < 100)
        temps = 1000.0
        recompense = 0
      else
        # Puis attribution du nombre d'étoiles en fonction du timer (à définir)
        if(temps < SEUIL_5_ETOILES)
          recompense = 5
        else
          if (temps < SEUIL_4_ETOILES)
            recompense = 4
          else
            if (temps < SEUIL_3_ETOILES)
              recompense = 3
            else
              if (temps < SEUIL_2_ETOILES)
                recompense = 2
              else
                if (temps < SEUIL_1_ETOILE)
                  recompense = 1
                else
                  recompense = 0
                end
              end
            end
          end
        end
      end

      @aventure.setEtoileCourante(recompense)
      @aventure.etoilesEnPlus(recompense)
      @aventure.setTempsCourant(temps)

      self.affichageEtoile(@aventure.getEtoileCourante())
      self.affichageTemps()
      self.affichageImageGrille()
    }

    @bouton[0].signal_connect('clicked'){
      self.setEffetBouton(0)
    }
    @bouton[1].signal_connect('clicked'){
      self.setEffetBouton(1)
    }
    @bouton[2].signal_connect('clicked'){
      self.setEffetBouton(2)
    }
    @bouton[3].signal_connect('clicked'){
      self.setEffetBouton(3)
    }
    @bouton[4].signal_connect('clicked'){
      self.setEffetBouton(4)
    }
    @bouton[5].signal_connect('clicked'){
      self.setEffetBouton(5)
    }
    @bouton[6].signal_connect('clicked'){
      self.setEffetBouton(6)
    }
    @bouton[7].signal_connect('clicked'){
      self.setEffetBouton(7)
    }
    @bouton[8].signal_connect('clicked'){
      self.setEffetBouton(8)
    }
    @bouton[9].signal_connect('clicked'){
      self.setEffetBouton(9)
    }

  end

end
