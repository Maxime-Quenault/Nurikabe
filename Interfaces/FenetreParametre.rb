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
            - peut afficher l'intterface qui va gérer les profils

        Les VI de cette classe sont :::
            - @profil ==> Le profil associé aux paramètres lorsque l'application est lancée
=end

class FenetreParametre < Fenetre

    attr_accessor :object

    def initialize(menuParent, interfaceProfil)
        self.initialiseToi
        @builder = Gtk::Builder.new(:file => 'glade/settingsNurikabe.glade')
        @object = @builder.get_object("menuParam")

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

    def gestionSignaux

        @btnProfils.signal_connect( "clicked" ) { 
            @interfaceProfil.afficheToi
        }

        @btnRetour.signal_connect( "clicked" ) {
            self.changerInterface(@menuParent, "Menu")
        }

        @switchTheme.signal_connect('notify::active') {onSwitchTheme_activated()}
        @switchTheme.set_active [false, true].sample

        @switchAudio.signal_connect('notify::active') {onSwitchAudio_activated()}
        @switchAudio.set_active [false, true].sample

        onChange_switchTheme()
        onChange_switchAudio()
    end

    def onSwitchTheme_activated()
        @paramProfil.themeSombre = @switchTheme.active? ? true : false
    end

    def onChange_switchTheme()
        if (@paramProfil.themeSombre == false)
            @switchTheme.set_active(false)
        else 
            @switchTheme.set_active(true)
        end
    end

    def onSwitchAudio_activated()
        @paramProfil.effetSonore = @switchAudio.active? ? true : false
    end

    def onChange_switchAudio()
        if (@paramProfil.effetSonore == false)
            @switchAudio.set_active(false)
        else 
            @switchAudio.set_active(true)
        end
    end

    def onChange_parametre()

    end
end