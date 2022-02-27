# https://prod.liveshare.vsengsaas.visualstudio.com/join?13F7D10A27BAEEA470A4FBFA2AB41657A004require 'gtk3'

#load 'Sauvegarde/Profil.rb'

=begin
        La classe AffichageParamètre :::
            - peut afficher l'interface qui va gérer la langue
            - peut afficher l'interface qui va gérer les couleurs
            - peut afficher l'interface qui va gérer les effets sonores
            - peut afficher l'intterface qui va gérer les profils

        Les VI de cette classe sont :::
            - @profil ==> Le profil associé aux paramètres lorsque l'application est lancée
=end



class AffichageParametre

    def initialize()
        self
        @interfaceProfil = FenetreProfil.new
    end

    def afficheLesParametres()
        #Gtk.init()

        def detruitLeBuilder()
            Gtk.main_quit
            return
        end

        unBuilder = Gtk::Builder.new
        unBuilder.add_from_file("glade/settingsNurikabe.glade")

        window = unBuilder.get_object("window_settings")
        window.signal_connect('destroy') {detruitLeBuilder} # destruction de la fenêtre quand on appuie sur la croix

        langue = unBuilder.get_object("cbt_langue")

        btnJeu = unBuilder.get_object("button_jeu")
        btnRetour = unBuilder.get_object("button_retour")
        btnProfils = unBuilder.get_object("button_profils")

        switchTheme = unBuilder.get_object("switch_theme")
        switchAudio = unBuilder.get_object("switch_audio")

        btnProfils.signal_connect( "clicked" ) { 
            #puts "Bouton profil cliqué\n"
            window.hide
            @interfaceProfil.afficheToi
            window.show_all
        }

        btnRetour.signal_connect( "clicked" ) { 
            window.hide
            detruitLeBuilder
        }

        window.show_all()
        Gtk.main
    end

end

### TESTS UNITAIRES ###

#uneSave = SauvegardeProfil.new()
#W_settings = AffichageParametre.new()
#W_settings.afficheLesParametres(uneSave)
