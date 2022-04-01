load 'Sauvegarde/Profil.rb'
load "Interfaces/Fenetre.rb"
load "Interfaces/FenetreProfil.rb"
load "Sauvegarde/SauvegardeProfil.rb"
load "Interfaces/FenetreParametreProfil.rb"
load "Parametre/Parametre.rb"
load "Interfaces/FenetreGrille.rb"

=begin
        La classe AffichageParamètre :::
            - peut afficher l'interface qui va gérer la langue
            - peut afficher l'interface qui va gérer les couleurs
            - peut afficher l'interface qui va gérer les effets sonores
            - peut afficher l'interface qui va gérer les profils
            - peut changer la couleur du thème
            - peut activer/désactiver les effets sonores
            - permet à l'utilisateur de gérer les profils
                    --> il pourra changer de profil quand il le souhaitera, ou même créer un nouveau profil

        Les VI de cette classe sont :::
            - @profil           ==> Le profil associé aux paramètres lorsque l'application est lancée
            - @bulder           ==> fenêtre principale qui va générer le fichier glade
            - @object           ==> contient l'identifiant de la fenêtre courante
            - @save             ==> une sauvegarde
            - @interfaceProfil  ==> pop-up des profils
            - @paramProfil      ==> paramètres courants du profil
            - @langue           ==> id de la langue
            - @btnJeu           ==> id du bouton jeu de l'interface paramètre
            - @btnRetour        ==> id du bouton retour de l'interface paramètre 
            - @btnProfil        ==> id du bouton profils dans l'interface paramètre
            - @switchTheme      ==> id du bouton switchTheme dans l'interface paramètre
=end

class FenetreParametre < Fenetre

    attr_accessor :object, :save

    ##
    # Méthode d'initialisation de la classe FenetreParametre
    def initialize(menuParent)
        self.initialiseToi
        @builder = Gtk::Builder.new(:file => 'glade/settingsNurikabe.glade')
        @object = @builder.get_object("menuParam")

        @save = SauvegardeProfil.new

        @interfaceParametreProfil = FenetreParametreProfil.new(menuParent, @object, @save)

        @langue = @builder.get_object("cbt_langue")

        @btnJeu = @builder.get_object("button_jeu")
        @btnRetour = @builder.get_object("button_retour")
        @btnProfil = @builder.get_object("button_profils")

        @btnJeu.name = "btn_jeu"
        @btnRetour.name = "btn_retour"
        @btnProfil.name = "btn_profil"

        @switchTheme = @builder.get_object("switch_theme")

        # récupération des boutons de changement de couleur de l'interface
        @red = @builder.get_object("ff0341")
        @purple = @builder.get_object("afa2ff")
        @green = @builder.get_object("92ff6e")
        @black = @builder.get_object("000000")
        @orange = @builder.get_object("ffab46")
        @pink = @builder.get_object("fe63ff")

        self.gestionSignaux

        @menuParent = menuParent
    end

    ##
    # Méthode qui gère les évènements liés aux signaux attribués aux différents composants du fichier glade
    def gestionSignaux

        @btnProfil.signal_connect( "clicked" ) { 
            self.changerInterface(@interfaceParametreProfil.object, "Paramètres")
        }

        @btnRetour.signal_connect( "clicked" ) {
            self.changerInterface(@menuParent, "Menu")
        }

        @switchTheme.signal_connect('notify::active') {onSwitchTheme_activated()}

        @red.signal_connect('clicked') {
            @@profilActuel.parametre.couleur = "\#FF0341"
            
            onChange_parametre()
        }
        @purple.signal_connect('clicked') {
            @@profilActuel.parametre.couleur = "\#AFA2FF"
            
            onChange_parametre()
        }
        @green.signal_connect('clicked') {
            @@profilActuel.parametre.couleur = "\#92FF6E"
            
            onChange_parametre()
        }
        @black.signal_connect('clicked') {
            @@profilActuel.parametre.couleur = "\#000000"
            
            onChange_parametre()
        }
        @orange.signal_connect('clicked') {
            @@profilActuel.parametre.couleur = "\#FFAB46"
            
            onChange_parametre()
        }
        @pink.signal_connect('clicked') {
            @@profilActuel.parametre.couleur = "\#FE63FF"
            
            onChange_parametre()
        }

        onChange_switchTheme()
    end

    ##
    # Méthode qui va changer la valeur du booleen themeSombre
    def onSwitchTheme_activated()
        @@profilActuel.parametre.themeSombre = @switchTheme.active? ? true : false
        onChange_parametre()
        setStyle(@@profilActuel)
    end

    ##
    # Change la valeur du switch Theme dans l'interface
    def onChange_switchTheme()
        if (@@profilActuel.parametre.themeSombre == false)
            @switchTheme.set_active(false)
        else 
            @switchTheme.set_active(true)
        end
    end

    ##
    # Méthode qui va mettre à jour les paramaètres en écrasant les anciennes données par les nouvelles
    def onChange_parametre()
        ajustementsCSS()
        @save.supprimerProfil(@@profilActuel)
        @save.ajoutProfil(@@profilActuel)
    end
    
end