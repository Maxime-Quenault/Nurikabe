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
		@btn_moyen.signal_connect("clicked"){print "\nTu as cliqué sur le mode Moyen"
			@interfaceChoixGrille.difficulte=1
			self.changerInterface(@interfaceChoixGrille.object, "Partie")
		}
=begin travail réalisé par Maxime, il le modifiera.
			self.changerInterface(@interfaceChoixGrille.object, "Moyen")
			if (unePartie = @@profilActuel.chercherPartie(2)) == nil
				g=Grille.creer()
				g.chargerGrille(2,0)
				creerPartie(g)
			else
				creerPartie(unePartie.grilleEnCours)
			end
			@interfaceGrille.construction
=end
		@btn_difficile.signal_connect("clicked"){print "\nTu as cliqué sur le mode Difficile"}
		@btn_retour.signal_connect("clicked"){
			self.changerInterface(@menuParent, "Menu")
			@@partie=nil
		}

	end

end





































=begin
	def not_yet_implemented(object)
		puts "#{object.class.name} sent a signal!"
	end

	def on_main_window_destroy(object)
		Gtk.main_quit()
	end


	def ajouterGrille(id)
		liste_grille = @builder.get_object('liste_grille')

		ligneGrille = Gtk::Box.new(:horizontal)
		ligneGrille.set_homogeneous(true)
		ligneGrille.set_size_request(-1, 40)

		# id de la grille
		ligneGrille.add(Gtk::Label.new(id.to_s), :expand => false, :fill => true)

		# aperçu de la grille
		ligneGrille.add(Gtk::Image.new(:stock => 'gtk-missing-image'), :expand => false, :fill => true)

		# taille de la grille
		ligneGrille.add(Gtk::Label.new('6x8'), :expand => false, :fill => true)

		# progression de la grille
		progressbar = Gtk::ProgressBar.new
		progressbar.set_halign(3)
		progressbar.set_valign(3)
		progressbar.set_pulse_step(0.10)
		progressbar.set_show_text(true)
		ligneGrille.add(progressbar, :expand => false, :fill => true)

		liste_grille.add_child(ligneGrille)
		liste_grille.show_all

	end
=end

