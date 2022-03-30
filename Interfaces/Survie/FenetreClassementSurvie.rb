require 'gtk3'

load "Interfaces/Fenetre.rb"
load "Sauvegarde/SauvegardeClassementSurvie.rb"
load "Interfaces/Survie/FenetreGrilleSurvie.rb"		
load "Sauvegarde/Score.rb"

class FenetreClassementSurvie < Fenetre
    attr :difficulte, true
    attr_accessor :object

	##
	# initialize :
	# 	Cette methode est le constructeur de la classe FenetreClassementCLM, il permet de recuperer
	#	le fichier glade et tout les objets qui le compose. Ensuite nous attribuons les bonnes 
	#	actions a chaque objets récupérés.
	#
	# @param menuParent represente l'interface parent, elle sera util pour le bouton retour en arrière.
    def initialize(menuParent)

        self.initialiseToi

		@menuParent = menuParent

		#recuperation du fichier glade
        @builder = Gtk::Builder.new(:file => 'glade/survie_nouvelle_partie.glade')
        @object = @builder.get_object("menu")

		#recuperation des boutons de l'interface
		@pseudo1 = @builder.get_object("pseudo1")
        @pseudo2 = @builder.get_object("pseudo2")
        @pseudo3 = @builder.get_object("pseudo3")
        @pseudo4 = @builder.get_object("pseudo4")
        @pseudo5 = @builder.get_object("pseudo5")
        @pseudo6 = @builder.get_object("pseudo6")
        @pseudo7 = @builder.get_object("pseudo7")
        @pseudo8 = @builder.get_object("pseudo8")
        @pseudo9 = @builder.get_object("pseudo9")
        @pseudo10 = @builder.get_object("pseudo10")

        @temps1 = @builder.get_object("temps1")
        @temps2 = @builder.get_object("temps2")
        @temps3 = @builder.get_object("temps3")
        @temps4 = @builder.get_object("temps4")
        @temps5 = @builder.get_object("temps5")
        @temps6 = @builder.get_object("temps6")
        @temps7 = @builder.get_object("temps7")
        @temps8 = @builder.get_object("temps8")
        @temps9 = @builder.get_object("temps9")
        @temps10 = @builder.get_object("temps10")

        @boutonPartie = @builder.get_object("btn_partie")
        @boutonRetour = @builder.get_object("btn_retour")
        @titre = @builder.get_object("titre")
		
        # Création d'une interface grille
        @interfaceGrille = FenetreGrilleSurvie.new(@object, self)
        
        #gestion et affiche par default
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

    def recupeTab
        @uneSave = SauvegardeClassementSurvie.new(self.getNumGrille)
        @tabScore = @uneSave.tabScore
        self.affichageScore
    end

    def ajoutScore
        unScore = Score.new(@interfaceGrille.getNbGrilles, @@profilActuel)
        @uneSave.ajoutScore(unScore)
        @tabScore = @uneSave.tabScore
        self.affichageScore
    end

	##
	# gestionSignaux :
	#	Cette methode permet d'assigner des actions à chaques boutons récupérés dans le fichier galde.
	def gestionSignaux

        @boutonRetour.signal_connect("clicked"){
            self.changerInterface(@menuParent, "Survie")
        }

        @boutonPartie.signal_connect("clicked"){
            construction
            self.changerInterface(@interfaceGrille.object, "Survie") #à modifier ensuite
        }

	end


    #génère la grille
    def construction
        @interfaceGrille.construction
    end

    def affichageScore()
    
        if @tabScore[0] != nil
            @pseudo1.set_text(@tabScore[0].profil.pseudo)
            @temps1.set_text("#{@tabScore[0]} grilles résolues")
        else
            @pseudo1.set_text("-")
            @temps1.set_text("-")
        end

        if @tabScore[1] != nil
            @pseudo2.set_text(@tabScore[1].profil.pseudo)
            @temps2.set_text("#{@tabScore[1]} grilles résolues")
        else
            @pseudo2.set_text("-")
            @temps2.set_text("-")
        end

        if @tabScore[2] != nil
            @pseudo3.set_text(@tabScore[2].profil.pseudo)
            @temps3.set_text("#{@tabScore[2]} grilles résolues")
        else
            @pseudo3.set_text("-")
            @temps3.set_text("-")
        end

        if @tabScore[3] != nil
            @pseudo4.set_text(@tabScore[3].profil.pseudo)
            @temps4.set_text("#{@tabScore[3]} grilles résolues")
        else
            @pseudo4.set_text("-")
            @temps4.set_text("-")
        end

        if @tabScore[4] != nil
            @pseudo5.set_text(@tabScore[4].profil.pseudo)
            @temps5.set_text("#{@tabScore[4]} grilles résolues")
        else
            @pseudo5.set_text("-")
            @temps5.set_text("-")
        end

        if @tabScore[5] != nil
            @pseudo6.set_text(@tabScore[5].profil.pseudo)
            @temps6.set_text("#{@tabScore[5]} grilles résolues")
        else
            @pseudo6.set_text("-")
            @temps6.set_text("-")
        end

        if @tabScore[6] != nil
            @pseudo7.set_text(@tabScore[6].profil.pseudo)
            @temps7.set_text("#{@tabScore[6]} grilles résolues")
        else
            @pseudo7.set_text("-")
            @temps7.set_text("-")
        end

        if @tabScore[7] != nil
            @pseudo8.set_text(@tabScore[7].profil.pseudo)
            @temps8.set_text("#{@tabScore[7]} grilles résolues")
        else
            @pseudo8.set_text("-")
            @temps8.set_text("-")
        end

        if @tabScore[8] != nil
            @pseudo9.set_text(@tabScore[8].profil.pseudo)
            @temps9.set_text("#{@tabScore[8]} grilles résolues")
        else
            @pseudo9.set_text("-")
            @temps9.set_text("-")
        end

        if @tabScore[9] != nil
            @pseudo10.set_text(@tabScore[9].profil.pseudo)
            @temps10.set_text("#{@tabScore[9]} grilles résolues")
        else
            @pseudo10.set_text("-")
            @temps10.set_text("-")
        end
    end

end

