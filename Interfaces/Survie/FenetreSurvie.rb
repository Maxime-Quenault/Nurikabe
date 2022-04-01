require 'gtk3'
load "Interfaces/Fenetre.rb"
load "Interfaces/Survie/FenetreClassementSurvie.rb"

##
# 	@author Quenault Maxime
#
#	Cette classe va permettre d'afficher le choix de difficulté du mode de jeu.
#
#	Voici les methodes de la classe FenetreSurvie :
#
#	- initialize : cette methode est le constructeur, elle recupere le fichier glade et initialise ses VI.
#	- gestionSignaux : permet d'attribuer des actions à tous les objets de l'interface récupéré dans le constructeur.
#   - getObjet : permet de recuperer l'interface courante
# 	- construction : construit la partie en chargant une grille voulue
#
#	Voici ses VI :
#
#	@menuParent : represente l'interface de menu parent, elle devra être affiché si on clique sur le bouton retour
#	@builder : represente le fichier glade
#	@object : represente l'interface de l'objet courent
#	@btn_facile : selectionne le niveau de difficulté FACILE
#	@btn_moyen : selectionne le niveau de difficulté MOYEN	
#	@btn_difficile : selectionne le niveau de difficulté DIFFICILE
#	@btn_retour : permet de revenir au menu parent
#	@interfaceClassement : represente l'interface qui devra être appelé au besoin

class FenetreSurvie < Fenetre
    attr_accessor :object
	
	##
	# initialize :
	# 	Cette methode est le constructeur de la classe FenetreSurvie, il permet de recuperer
	#	le fichier glade et tout les objets qui le compose. Ensuite nous attribuons les bonnes 
	#	actions a chaque objets récupérés.
	#
	# @param menuParent represente l'interface parent, elle sera util pour le bouton retour en arrière.
    def initialize(menuParent)

        self.initialiseToi

		@menuParent = menuParent

		#recuperation du fichier glade
        @builder = Gtk::Builder.new(:file => 'glade/menu-libre.glade')
        @object = @builder.get_object("menu")

		titre = @builder.get_object('titre')
        titre.set_text("MODE SURVIE")

		#recuperation des boutons de l'interface
		@btn_facile = @builder.get_object("lvl_facile")
		@btn_moyen = @builder.get_object("lvl_moyen")
		@btn_difficile = @builder.get_object("lvl_difficile") 
		@btn_retour = @builder.get_object("btn_retour")

		@btn_facile.name = "boutonDiffSurvie"
		@btn_moyen.name = "boutonDiffSurvie"
		@btn_difficile.name = "boutonDiffSurvie"
		@btn_retour.name = "retour_fleche"

		@interfaceClassement = FenetreClassementSurvie.new(@object)
		
		self.gestionSignaux

    end

    ##
	# getObjet:
	# 	Cette methode permet d'envoyer sont objet (interface) a l'objet qui le demande.
	#
	# @return object qui represente l'interface de la fenetre du mode libre.
	def getObjet
		return @object
	end


	##
	# gestionSignaux:
	#	Cette methode permet d'assigner des actions à chaques boutons récupérés dans le fichier galde.
	def gestionSignaux

		@btn_facile.signal_connect("clicked"){
			@interfaceClassement.difficulte=0
			construction(rand(10))
			@interfaceClassement.recupeTab
			self.changerInterface(@interfaceClassement.object, "Facile")
		}
		@btn_moyen.signal_connect("clicked"){
			@interfaceClassement.difficulte=1
			construction(rand(10))
			@interfaceClassement.recupeTab
			self.changerInterface(@interfaceClassement.object, "Moyen")
		}

		@btn_difficile.signal_connect("clicked"){
			@interfaceClassement.difficulte=2
			construction(rand(10))
			@interfaceClassement.recupeTab
			self.changerInterface(@interfaceClassement.object, "Difficile")
		}
		@btn_retour.signal_connect("clicked"){
			self.changerInterface(@menuParent, "Menu")
			@@partie=nil
		}

	end

	##
	# construction:
	#	Construit la partie en chargant une grille voulue
	# @param num_grille represente le numero de la grille
	def construction(num_grille)
		g=Grille.creer()
		g.difficulte=@interfaceClassement.difficulte
		g.chargerGrille(num_grille,@interfaceClassement.difficulte)
		creerPartie(g)
		@@partie.chronometre=ChronometreSurvie.creer()
    end
end