require 'gtk3'
load "Interfaces/Fenetre.rb"
load "Interfaces/Survie/FenetreClassementSurvie.rb"

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

		@interfaceClassement = FenetreClassementSurvie.new(@object)
		
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

	 #Construit la partie en chargant une grille voulue
	 def construction(num_grille)
        if (unePartie = @@profilActuel.chercherPartie(num_grille, @interfaceClassement.difficulte)) == nil
            g=Grille.creer()
            g.difficulte=@interfaceClassement.difficulte
            g.chargerGrille(num_grille,@interfaceClassement.difficulte)
            creerPartie(g)
            @@partie.chronometre=ChronometreSurvie.creer()
		else
            @@partie = unePartie
        end
        #@interfaceClassement.construction
    end
end