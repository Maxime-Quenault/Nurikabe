#!/usr/bin/env ruby

require 'gtk3'

class Libre

	def not_yet_implemented(object)
		puts "#{object.class.name} a envoyé un signal !"
	end

	def initialize
		main_window_res = '../glade/menu-libre.glade'

		@builder = Gtk::Builder.new(:file => main_window_res)

		# Attache les handlers aux signaux (si le nom de l'handler est déjà donné au signal)
		@builder.connect_signals do |handler|
		begin
			method(handler)
			rescue
				puts "#{handler} n'est pas implémentée"
				method('not_yet_implemented')
			end
		end

	end

	# Affiche la fenêtre du mode libre
	def afficheToi

		main_window = @builder.get_object('main_window')
		main_window.show()

		Gtk.main

	end

	# Handler du signal de destruction de la fenêtre qui quitte la fenêtre
	def detruisToi
		Gtk.main_quit
	end

	# Ajoute une ligne présentant une sauvegarde dans la liste de grille
	# @param id [Integer] l'id de la grille qui va être ajouté dans la liste de grille
	def ajouterGrille(id)
		liste_grille = @builder.get_object('liste_grille')

		ligneGrille = Gtk::Box.new(:horizontal)
		ligneGrille.set_homogeneous(true)
		ligneGrille.set_size_request(-1, 40)

		# id de la grille
		ligneGrille.add(Gtk::Label.new('#' + id.to_s), :expand => false, :fill => true)

		# aperçu de la grille
		# ligneGrille.add(Gtk::Image.new(:stock => 'gtk-missing-image'), :expand => false, :fill => true)

		# taille de la grille
		ligneGrille.add(Gtk::Label.new('6x8'), :expand => false, :fill => true)

		# progression de la grille
		progressbar = Gtk::ProgressBar.new
		progressbar.set_halign(3)
		progressbar.set_valign(3)
		progressbar.set_fraction(rand(100) / 100.0)
		progressbar.set_pulse_step(0.1)
		progressbar.set_show_text(true)
		ligneGrille.add(progressbar, :expand => false, :fill => true)

		liste_grille.add_child(ligneGrille)
		liste_grille.show_all

	end

	def demarrer(uneDifficulte)
		puts "start ! #{uneDifficulte.class.name}"
	end

end

ml = Libre.new()
ml.ajouterGrille(1)
ml.ajouterGrille(4)
ml.ajouterGrille(7)
ml.ajouterGrille(9)
ml.ajouterGrille(15)
ml.ajouterGrille(20)
ml.ajouterGrille(31)
ml.ajouterGrille(36)
ml.ajouterGrille(41)
ml.ajouterGrille(42)
ml.ajouterGrille(43)
ml.ajouterGrille(50)
ml.ajouterGrille(52)
ml.ajouterGrille(54)
ml.ajouterGrille(66)
ml.ajouterGrille(68)
ml.ajouterGrille(70)
ml.ajouterGrille(71)
ml.ajouterGrille(73)
ml.ajouterGrille(81)
ml.ajouterGrille(87)
ml.ajouterGrille(89)
ml.ajouterGrille(94)
ml.ajouterGrille(97)

ml.afficheToi
