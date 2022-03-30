require 'gtk3'
load "Interfaces/Fenetre.rb"
load "Interfaces/ContreLaMontre/FenetreChoixGrilleCLM.rb"

class FenetreContreMontre < Fenetre

    attr_accessor :object

	##
	# initialize :
	# 	Cette methode est le constructeur de la classe FenetreContreLaMontre, il permet de recuperer
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
        titre.set_text("MODE CONTRE-LA-MONTRE")

		#recuperation des boutons de l'interface
		@btn_facile = @builder.get_object("lvl_facile")
		@btn_moyen = @builder.get_object("lvl_moyen")
		@btn_difficile = @builder.get_object("lvl_difficile") 
		@btn_retour = @builder.get_object("btn_retour")

		@interfaceChoixGrille = FenetreChoixGrilleCLM.new(@object)
		
		self.gestionSignaux

    end

    ##
	# getObjet :
	# 	Cette methode permet d'envoyer sont objet (interface) a l'objet qui le demande.
	#
	# @return object qui represente l'interface de la fenetre du mode libre.
	def getObjet
		return @object
	end


	##
	# gestionSignaux :
	#	Cette methode permet d'assigner des actions à chaques boutons récupérés dans le fichier galde.
	def gestionSignaux

		@btn_facile.signal_connect("clicked"){
			@interfaceChoixGrille.difficulte=0
			self.changerInterface(@interfaceChoixGrille.object, "Facile")
		}
		@btn_moyen.signal_connect("clicked"){print "\nTu as cliqué sur le mode Moyen"
			@interfaceChoixGrille.difficulte=1
			self.changerInterface(@interfaceChoixGrille.object, "Moyen")
		}

		@btn_difficile.signal_connect("clicked"){print "\nTu as cliqué sur le mode Difficile"
			@interfaceChoixGrille.difficulte=2
			self.changerInterface(@interfaceChoixGrille.object, "Difficile")
		}
		@btn_retour.signal_connect("clicked"){
			self.changerInterface(@menuParent, "Menu")
			@@partie=nil
		}

	end
end