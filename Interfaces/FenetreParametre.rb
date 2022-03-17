load 'Sauvegarde/Profil.rb'
load "Interfaces/Fenetre.rb"
load "Interfaces/FenetreProfil.rb"
load "Sauvegarde/SauvegardeProfil.rb"
load "Parametre/Parametre.rb"

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
            - @btnProfils       ==> id du bouton profils dans l'interface paramètre
            - @switchTheme      ==> id du bouton switchTheme dans l'interface paramètre
            - @switchAudio      ==> id du bouton switchAudio dans l'interface paramètre
=end

class FenetreParametre < Fenetre

    attr_accessor :object

    ##
    # Méthode d'initialisation de la classe FenetreParametre
    def initialize(menuParent, interfaceProfil)
        self.initialiseToi
        @builder = Gtk::Builder.new(:file => 'glade/settingsNurikabe.glade')
        @object = @builder.get_object("menuParam")

        @save = SauvegardeProfil.new

        @interfaceProfil = interfaceProfil

        @paramProfil = @interfaceProfil.profil.parametre

        @langue = @builder.get_object("cbt_langue")

        @btnJeu = @builder.get_object("button_jeu")
        @btnRetour = @builder.get_object("button_retour")
        @btnProfils = @builder.get_object("button_profils")

        @switchTheme = @builder.get_object("switch_theme")
        @switchAudio = @builder.get_object("switch_audio")

        self.gestionSignaux

        @menuParent = menuParent
    end

    ##
    # Méthode qui g ère les évènements liés aux signaux attribués aux différents composants du fichier glade
    def gestionSignaux

        @btnProfils.signal_connect( "clicked" ) { 
            @interfaceProfil.afficheToi
        }

        @btnRetour.signal_connect( "clicked" ) {
            self.changerInterface(@menuParent, "Menu")
        }
        

        @switchTheme.signal_connect('notify::active') {onSwitchTheme_activated()}
        @switchAudio.signal_connect('notify::active') {onSwitchAudio_activated()}

        onChange_switchTheme()
        onChange_switchAudio()
    end

    ##
    # Méthode qui va changer la valeur du booleen themeSombre
    def onSwitchTheme_activated()
        @paramProfil.themeSombre = @switchTheme.active? ? true : false
        onChange_parametre()
    end

    ##
    # Change la valeur du switch Theme dans l'interface
    def onChange_switchTheme()
        if (@paramProfil.themeSombre == false)
            @switchTheme.set_active(false)
        else 
            @switchTheme.set_active(true)
        end
    end

    ##
    # Méthode qui va changer la valeur du booleen effetSonore
    def onSwitchAudio_activated()
        @paramProfil.effetSonore = @switchAudio.active? ? true : false
        onChange_parametre()
    end

    ##
    # Change la valeur du switch Audio dans l'interface
    def onChange_switchAudio()
        if (@paramProfil.effetSonore == false)
            @switchAudio.set_active(false)
        else 
            @switchAudio.set_active(true)
        end
    end

    ##
    # Méthode qui va mettre à jour les paramaètres en écrasant les anciennes données par les nouvelles
    def onChange_parametre()
        @save.supprimerProfil(@@profilActuel)
        @save.ajoutProfil(@@profilActuel)
    end
end