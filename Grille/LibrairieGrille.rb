#!/usr/bin/env ruby

require 'gtk3'
require './Grille/LectureGrille.rb'

class LibrairieGrille

    def not_yet_implemented(object)
		puts "#{object.class.name} a envoyé un signal !"
	end

	def initialize
		main_window_res = './glade/menu-librairie.glade'

		@builder = Gtk::Builder.new(:file => main_window_res)
        @css = Gtk::CssProvider.new
        @css.load(:data => "#grilleFinie {border: 2px solid lime;}")

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

    def afficheGrille(id)

        @grid_grilles = @builder.get_object('grid_grilles')
        
        boutonGrille = Gtk::Button.new()
        contenuBoutonG = Gtk::Box.new(:vertical)

        titreBoutonG = Gtk::Label.new('Grille #' + (id + 1).to_s)
        titreBoutonG.set_margin_top(5)
        titreBoutonG.set_margin_bottom(5)
        contenuBoutonG.add(titreBoutonG, :expand => false, :fill => true)
        contenuBoutonG.add(Gtk::Image.new(:file => './Grille/img/placeholder_grille.png').show)

        boutonGrille.add_child(contenuBoutonG)

        # <!!> Classe à ajouter si la grille est finie - à voir avec les sauvegardes donc.
        # boutonGrille.set_name('grilleFinie')

        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, @css, Gtk::StyleProvider::PRIORITY_APPLICATION)
        
        @grid_grilles.attach(boutonGrille, @pos_h, @pos_v, 1, 1)

        if @pos_h < 2
            @pos_h += 1
        else
            @pos_h = 0
            @pos_v += 1
        end

    end

    # Initialise la liste de grilles à afficher dans la librairie
    def initGrilles(uneDifficulte)

        @pos_v = 0
        @pos_h = 0

        p = LectureGrille.new()
        i = 0
        while p.lireGrille(i, uneDifficulte) != "" do
            afficheGrille(i)
            i += 1
        end

        @grid_grilles.show_all

    end

    # Affiche la fenêtre librairie de grilles
	def afficheToi
        
        initGrilles(0)

		main_window = @builder.get_object('main_window')
		main_window.show()

		Gtk.main

	end

    # Handler du signal de destruction de la fenêtre qui quitte la fenêtre
	def detruisToi
		Gtk.main_quit
	end

end

lib = LibrairieGrille.new()



lib.afficheToi()