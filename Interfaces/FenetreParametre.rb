
# https://prod.liveshare.vsengsaas.visualstudio.com/join?13F7D10A27BAEEA470A4FBFA2AB41657A004require 'gtk3'

#load 'Sauvegarde/Profil.rb'
load "Interfaces/Fenetre.rb"
load "Interfaces/FenetreProfil.rb"

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

    def initialize()
        self.initialiseToi
        @builder = Gtk::Builder.new(:file => 'glade/settingsNurikabe.glade')
        @object = @builder.get_object("menuParam")

        @interfaceProfil = FenetreProfil.new

        @langue = @builder.get_object("cbt_langue")

        @btnJeu = @builder.get_object("button_jeu")
        @btnRetour = @builder.get_object("button_retour")
        @btnProfils = @builder.get_object("button_profils")

        @switchTheme = @builder.get_object("switch_theme")
        @switchAudio = @builder.get_object("switch_audio")

        self.gestionSignaux
    end

    def afficheToi
        self.affichage
    end

    

    def affichage
        super(@object, "Parametre")
    end

    def gestionSignaux
        @btnProfils.signal_connect( "clicked" ) { 
            print "\nTu as clique sur profil"
            @interfaceProfil.afficheToi
        }

        @btnRetour.signal_connect( "clicked" ) {
            self.deleteChildren()
            Gtk.main_quit
        }
    end

end