require 'gtk3'

class Fenetre

    @@window = nil

    def initialize

        Gtk.init
        
        @@window = Gtk::Window.new()

        #Option de la fenetre
        @@window.set_default_size(745,850)
        @@window.set_width_request(745)
        @@window.set_height_request(850)
        @@window.set_resizable(false)
        @@window.signal_connect("destroy") { quitter }
        @@window.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)

        #Creation header
        @header = Gtk::HeaderBar.new
        @header.show_close_button = true
        @header.name = "headerbar"
        @header.title = "Nurikabe"
        @header.subtitle = "-"
        @@window.titlebar = @header
    end

    ##
    # Permet d'initialiser une seule fois une fenetre
    def initialiseToi()
        puts @@window
        if @@window == nil
            Fenetre.new()
        else
            puts "fenetre deja initialise"
        end
    end

    ##
    # Permet de changer les sous-titre de la fenetre
    def set_sousTitre(subtitle)
        @@window.titlebar.subtitle  = subtitle
    end

    def affichage(unObjet, unSousTitre)
        @@window.add(unObjet)
        self.set_sousTitre(unSousTitre)
        @@window.show_all
        Gtk.main
    end

    def remove(unObjet)
        @@window.remove(unObjet)
    end

    def quitter
        Gtk.main_quit
    end

end