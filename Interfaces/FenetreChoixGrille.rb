require 'gtk3'
include Gtk

load "./Interfaces/Fenetre.rb"
load "./Interfaces/FenetreGrille.rb"
load "./Grille/LectureGrille.rb"

##
#   Affiches les différentes grilles parmis lesquelles l'utilisateur peut choisir
#
#
#   Voici ses méthodes : 
#
#   - gestionSignaux : permet d'affecter un role a chaque objet de l'interface
#   - afficheGrille : permet d'afficher la grille à l'ecran
#   - initGrilles : permet d'initialiser la liste de grille qui devra être affichée
#   - construction : permet de construire la grille qui sera cliqué
#
#   Voici ses VI :
#
#   - @difficulte : represente la difficulté choisi par le joueur
#   - @builder : represente le fichier glade
#   - @object : represente l'interface courante
#   - @boutons : representes les boutons de la grille jouable
#   - @menuParent : represetne l'interface parent qui sera afficher si le joueur clique sur retour
#   - @interfaceGrille : represetne l'interface grille
#   - @btn_retour : represente le bouton retour
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

    ##
    # gestionSignaux:
    #   permet de gerer les signaux des objets du buildeur
    def gestionSignaux
        
        # Recuperation de la fenetre
        @btn_retour = @builder.get_object('btn_retour')

        @btn_retour.name = "retour_fleche"

		initGrilles(0)

        #Gestion des signaux
        @btn_retour.signal_connect('clicked'){#quitter
            self.changerInterface(@menuParent, "Libre")
        }

    end

    ##
    # afficheGrille:
    #   permet d'afficher une grille
    #
    # @param id represente l'identifiant de la grille à afficher
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

    ##
    # initGrilles:
	#   Initialise la liste de grilles à afficher dans la librairie
    #
    # @param uneDifficulte represetne le niveau de difficulté choisi pour afficher les bonnes grilles
    def initGrilles(uneDifficulte)

        @pos_v = 0
        @pos_h = 0

        p = LectureGrille.new()
        i = 0
		
        while p.lireGrille(i, uneDifficulte) != "END" do
            afficheGrille(i)
            i += 1
        end

    end

    ##
    # construction:
    #   Créer une table de boutons correspondants aux cases de la grille
    #
    # @param num_grille represente le numero de la grille qui devra être construit pour plus tard être jouable
    def construction(num_grille)
        if (unePartie = @@profilActuel.chercherPartie(num_grille, @difficulte)) == nil
            g=Grille.creer()
            g.difficulte=difficulte
            g.chargerGrille(num_grille,@difficulte)
            creerPartie(g)
        else
            @@partie = unePartie
        end
        @interfaceGrille.construction
    end

end