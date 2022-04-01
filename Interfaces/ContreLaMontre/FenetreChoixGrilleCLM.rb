require 'gtk3'
include Gtk

load "./Interfaces/Fenetre.rb"
load "./Interfaces/ContreLaMontre/FenetreGrilleCLM.rb"
load "./Grille/LectureGrille.rb"
load "Sauvegarde/SauvegardeClassementContreLaMontre.rb"
load "Interfaces/ContreLaMontre/FenetreClassementCLM.rb"

##
# 	@author Quenault Maxime / Lebouc Julian
#
#	Cette classe va permettre d'afficher une liste de grille selon une difficulté,
#   ce qui permettra au joueur de séléctionner la grille de sont choix.
#
#	Voici les methodes de la classe FenetreChoixGrilleCLM :
#
#	- initialize : cette methode est le constructeur, elle recupere le fichier glade et initialise ses VI.
#	- gestionSignaux : permet d'attribuer des actions à tous les objets de l'interface récupéré dans le constructeur.
#   - afficheGrille : Cette methode permet d'afficher une grille à l'ecran de séléction des grilles.
#   - initGrilles : Initialise la liste de grilles à afficher dans la librairie
#   - construction : Créer une table de boutons correspondants aux cases de la grille.
#
#	Voici ses VI :
#
#	@builder : represente le fichier glade
#	@object : represente l'interface de la classe
#   @boutons : represente les boutons pour selectionner la grille que l'on veut jouer
#   @menuParent : represente l'interface de menu parent, elle devra être affiché si on clique sur le bouton retour
#   @difficulte : represente la difficulté des grilles à initialiser
#   @tempGrille : represente une grille de previsualisation 
#   @interfaceClassement : represente l'interface du classement du mode de jeu
#   @grid_grilles : represente l'objet qui va contenir la grille de previsualisation
#   @pos_v : represente la position verticale d'un element de la grille de previsualisation
#   @pos_h : represente la position horizontal d'un element de la grille de previsualisation
#

class FenetreChoixGrilleCLM < Fenetre

    attr_accessor :object
    attr :difficulte, true

    ##
	# initialize :
	# 	Cette methode est le constructeur de la classe FenetreChoixGrilleCLM, il permet de recuperer
	#	le fichier glade et tout les objets qui le compose. Ensuite nous attribuons les bonnes 
	#	actions a chaque objets récupérés.
	#
	# @param menuParent represente l'interface parent, elle sera util pour le bouton retour en arrière.
    def initialize(menuParent)
        self.initialiseToi
        @difficulte
        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/menu-choix-grille.glade")
        @object = @builder.get_object("menu")
        @boutons
        @menuParent = menuParent

        @tempGrille = FenetreGrille.new(@object)
        @interfaceClassement = FenetreClassementCLM.new(@object)

        self.gestionSignaux
    end

    ##
	# gestionSignaux:
	#	Cette methode permet d'assigner des actions à chaques boutons récupérés dans le fichier galde.
    #   Egalement, elle permet d'initialiser la liste des grilles facile.
    def gestionSignaux
        
        btn_retour = @builder.get_object('btn_retour')

        initGrilles(0)

        btn_retour.signal_connect('clicked'){#quitter
            self.changerInterface(@menuParent, "Contre-la-montre")
        }

    end

    ##
    # afficheGrille:
    #   Cette methode permet d'afficher une grille à l'ecran de séléction des grilles.
    # @param id represente le numero de la grille à afficher. 
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

        contenuBoutonG.add( @tempGrille.afficheGrille(g.hauteur, g.largeur, g) )
        boutonGrille.add_child(contenuBoutonG)
		boutonGrille.signal_connect('clicked'){
            self.setNumGrille(id)
            construction(id)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
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
    # @param uneDifficulte represente la dificulté des grilles à initialiser.
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
    #   Créer une table de boutons correspondants aux cases de la grille.
    # @param num_grille represente le numero de la grille à construire une fois qu'elle est cliqué.
    def construction(num_grille)
        g=Grille.creer()
        g.difficulte=@difficulte
        g.chargerGrille(num_grille,@difficulte)
        creerPartie(g)
    end

end

