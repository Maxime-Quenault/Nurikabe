require 'gtk3'
include Gtk

load "Sauvegarde/Profil.rb"

class FenetreAPropos

    attr_accessor :profil, :quit
    def initialize
        @quit = false
        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/apropos.glade")
    end


    def afficheToi
        Gtk.init
        #Recuperation de la fenetre
        windowAPropos = @builder.get_object("test")

        #affichage de la fenetre
        windowAPropos.show

        Gtk.main
    end
end