require 'gtk3'
include Gtk

load "./Interfaces/Fenetre.rb"
load "./Interfaces/FenetreGrille.rb"
load "./Grille/LectureGrille.rb"

class FenetreChoixGrille < Fenetre

    attr_accessor :object
    attr :difficulte, true

    def initialize(menuParent)
        self.initialiseToi
        @difficulte
        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/menu-choix-grille.glade")
        @object = @builder.get_object("menu")
        @boutons
        @menuParent = menuParent
        @interfaceGrille = FenetreGrille.new(@object)
        self.gestionSignaux
    end

    def gestionSignaux
        
        # Recuperation de la fenetre
        btn_retour = @builder.get_object('btn_retour')

		initGrilles(0)

        #Gestion des signaux
        btn_retour.signal_connect('clicked'){#quitter
            self.changerInterface(@menuParent, "Libre")
        }

    end

	def afficheGrille(id)

        @grid_grilles = @builder.get_object('grid_grilles')
        
        boutonGrille = Gtk::Button.new()
        contenuBoutonG = Gtk::Box.new(:vertical)

        titreBoutonG = Gtk::Label.new('Grille #' + (id + 1).to_s)
        titreBoutonG.set_margin_top(5)
        titreBoutonG.set_margin_bottom(5)
        contenuBoutonG.add(titreBoutonG, :expand => false, :fill => true)

		# On ajoute l'affichage de la grille dans son bouton
		g = Grille.creer()
		g.difficulte = 0
		g.chargerGrille(id, 0)

        contenuBoutonG.add( @interfaceGrille.afficheGrille(g.hauteur, g.largeur, g) )

        boutonGrille.add_child(contenuBoutonG)

        # <!!> Classe à ajouter si la grille est finie - à voir avec les sauvegardes donc.
        # boutonGrille.set_name('grilleFinie')

		boutonGrille.signal_connect('clicked'){#quitter
            construction(id)
            self.changerInterface(@interfaceGrille.object, "Partie")
        }

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
        while p.lireGrille(i, uneDifficulte) != "END" do
            afficheGrille(i)
            i += 1
        end

		puts "rien"

        # @grid_grilles.show_all

    end

    #Créer une table de boutons correspondants aux cases de la grille
    def construction(num_grille)
        if (unePartie = @@profilActuel.chercherPartie(num_grille, @difficulte)) == nil
            g=Grille.creer()
            g.difficulte=difficulte
            g.chargerGrille(num_grille,@difficulte)
            creerPartie(g)
        else
            print "\ntu as une partie de save"
            @@partie = unePartie
        end
        @interfaceGrille.construction
    end

end

=begin
if @@partie.grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
    table.attach(Button.new(:label=> (@@partie.grilleEnCours.matriceCases[i][j].valeur).to_s), i, i+1, j, j+1)
else
    table.attach(Button.new(:label=> ""), i, i+1, j, j+1)
end
=end