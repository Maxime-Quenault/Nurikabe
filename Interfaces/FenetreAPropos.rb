require 'gtk3'
include Gtk

load "Interfaces/Fenetre.rb"

class FenetreAPropos < Fenetre

    def initialize(menuParent)
        self.initialiseToi

        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/apropos.glade")

        @menuParent = menuParent
    end
end