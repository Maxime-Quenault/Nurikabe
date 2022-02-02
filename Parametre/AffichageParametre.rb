require 'gtk3'

load '../Sauvegarde/SauvegardeProfil.rb'

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
    end

    def afficheLesParametres( uneSave )
        Gtk.init()

        def detruitLeBuilder()
            Gtk.main_quit
            return
        end

        unBuilder = Gtk::Builder.new
        unBuilder.add_from_file("../glade/settingsNurikabe.glade")

        window = unBuilder.get_object("window_settings")
        window.signal_connect('destroy') {detruitLeBuilder} # destruction de la fenêtre quand on appuie sur la croix

        langue = unBuilder.get_object("cbt_langue")

        btnJeu = unBuilder.get_object("button_jeu")
        btnRetour = unBuilder.get_object("button_retour")
        btnProfils = unBuilder.get_object("button_profils")

        switchTheme = unBuilder.get_object("switch_theme")
        switchAudio = unBuilder.get_object("switch_audio")

        btnProfils.signal_connect( "clicked" ) { puts "Bouton profil cliqué\n" }

        window.show_all()
        Gtk.main
    end

end

uneSave = SauvegardeProfil.new()
W_settings = AffichageParametre.new()
W_settings.afficheLesParametres(uneSave)
