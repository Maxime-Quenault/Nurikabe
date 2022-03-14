require 'gtk3'
include Gtk

load "Interfaces/Fenetre.rb"

class FenetreAPropos < Fenetre

    attr_accessor :object

    def initialize(menuParent)
        self.initialiseToi

        @builder = Gtk::Builder.new(:file => 'glade/apropos.glade')
        @object = @builder.get_object("menuAPropos")

        @btnRetour = @builder.get_object("btnRetour")

        @menuParent = menuParent

        self.gestionSignaux
    end

    def gestionSignaux()
        @btnRetour.signal_connect( "clicked" ) {
            self.changerInterface(@menuParent, "Menu")
        }
    end
end