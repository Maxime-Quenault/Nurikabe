class Libre


	def not_yet_implemented(object)
		puts "#{object.class.name} sent a signal!"
	end

	def on_main_window_destroy(object)
		Gtk.main_quit()
	end

	def initialize
		main_window_res = '../glade/menu-libre.glade'

		@builder = Gtk::Builder.new(:file => main_window_res)

		# Attach signals handlers
		@builder.connect_signals do |handler|
		begin
			method(handler)
			rescue
				puts "#{handler} not yet implemented!"
				method('not_yet_implemented')
			end
		end

	end

	def afficheToi

		main_window = @builder.get_object('main_window')
		main_window.show()

		Gtk.main

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


    def toGrilleJouable(unIndex, uneDifficulte)

        chaine = lireGrille(unIndex, uneDifficulte)

        numeroCases = chaine.lines.first.split(' ')
        grille = chaine.lines.drop(1)

        #Création de la matrice de cases
        matriceCases = Array.new(grille.length) {Array.new(grille[0].split.lenght)}

        y = 0 
        compteur = 0

        grille.each_with_index do |line, index|
            x = 0
            for j in grille[index].split do
                if( j=="0" || j == 0 )
                    matriceCases[y][x] = grille[index][line] + 1 
                else
                    matriceCases[y][x] = j.to_i
                    
                end

                x += 1
            end
            y += 1
        end

    end

end
