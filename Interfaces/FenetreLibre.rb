require 'gtk3'

load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"
load "Libre/Libre.rb"
load "Interfaces/Fenetre.rb"
load "Interfaces/FenetreChoixGrille.rb"


##
# 	@author Quenault Maxime / ... (mettez vos nom ce qu'on travailler sur l'interface du mode libre)
#
#	Cette classe va gerer l'interface du mode Libre. Pour cela elle récupère le fichier glade associé
#	et initialise toutes ses variables d'instance avec les objets du fichier glade.
#
#	Voici les methodes de la classe FenetreLibre :
#
#	- initialize : cette methode est le constructeur, elle recupere le fichier glade et initialise ses VI.
#	- getObjet : permet de renvoyer sont interface à tous ceux qui la demande.
#	- gestionSignaux : permet d'attribuer des actions à tous les objets de l'interface récupéré dans le constructeur.
#
#	Voici ses VI :
#
#	@menuParent : represente l'interface du menu parent
#	@builder : represente le fichier glade
#	@object : represente l'interface de la classe
#	@btn_facile : represente l'objet bouton facile
#	@btn_moyen : represente l'objet bouton moyen
#	@btn_difficile : represente l'objet bouton difficile
#	@btn_retour : represente l'objet bouton retour
#	

class FenetreLibre < Fenetre

    attr_accessor :object

	##
	# initialize :
	# 	Cette methode est le constructeur de la classe FenetreLibre, il permet de recuperer
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

		#recuperation des boutons de l'interface
		@btn_facile = @builder.get_object("lvl_facile")
		@btn_moyen = @builder.get_object("lvl_moyen")
		@btn_difficile = @builder.get_object("lvl_difficile") 
		@btn_retour = @builder.get_object("btn_retour")

		@btn_retour.name = "retour_fleche"

		@btn_facile.name = "boutonDiffLibre"
		@btn_moyen.name = "boutonDiffLibre"
		@btn_difficile.name = "boutonDiffLibre"

		@interfaceChoixGrille = FenetreChoixGrille.new(@object)
		
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
		@btn_moyen.signal_connect("clicked"){
			@interfaceChoixGrille.difficulte=1
			self.changerInterface(@interfaceChoixGrille.object, "Partie")
		}

		@btn_difficile.signal_connect("clicked"){
			@interfaceChoixGrille.difficulte=2
			self.changerInterface(@interfaceChoixGrille.object, "Partie")
		}
		@btn_retour.signal_connect("clicked"){
			self.changerInterface(@menuParent, "Menu")
			@@partie=nil
		}

	end

end

