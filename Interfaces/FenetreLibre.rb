require 'gtk3'

load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"
load "Libre/Libre.rb"
load "Interfaces/Fenetre.rb"

class FenetreLibre < Fenetre

    attr_accessor :modeLibre, :object

    def initialize
        self.initialiseToi
        @builder = Gtk::Builder.new(:file => 'glade/menu-libre.glade')
        @object = @builder.get_object("menu")

		@btn_facile = @builder.get_object("lvl_facile")
		@btn_moyen = @builder.get_object("lvl_moyen")
		@btn_difficile = @builder.get_object("lvl_difficile") 
		@btn_retour = @builder.get_object("btn_retour")

		self.gestionSignaux
    end

    def afficheToi
		self.affichage
	end

	def affichage
		print "\nj'affiche le fenetre libre"
		super(@object, "Mode Libre")
	end

	def gestionSignaux
		@btn_facile.signal_connect("clicked"){print "\nTu as cliqué sur le mode Facile"}
		@btn_moyen.signal_connect("clicked"){print "\nTu as cliqué sur le mode Moyen"}
		@btn_difficile.signal_connect("clicked"){print "\nTu as cliqué sur le mode Difficile"}

		@btn_retour.signal_connect("clicked"){
			self.deleteChildren()
			Gtk.main_quit
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