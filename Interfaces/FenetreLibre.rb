require 'gtk3'

load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"
load "Libre/Libre.rb"
load "Interfaces/Fenetre.rb"

##
# @author Quenault Maxime / ... (mettez vos nom ce qu'on travailler sur l'interface du mode libre)
#
#
#
#
#
#
#
#
#
#
#


class FenetreLibre < Fenetre

    attr_accessor :modeLibre, :object

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

		@btn_facile.signal_connect("clicked"){print "\nTu as cliqué sur le mode Facile"}
		@btn_moyen.signal_connect("clicked"){print "\nTu as cliqué sur le mode Moyen"}
		@btn_difficile.signal_connect("clicked"){print "\nTu as cliqué sur le mode Difficile"}
		@btn_retour.signal_connect("clicked"){
			self.changerInterface(@menuParent, "Menu")
		}

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

end