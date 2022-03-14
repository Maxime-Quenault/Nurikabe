require 'gtk3'
include Gtk

load "Interfaces/Fenetre.rb"

class FenetreAPropos < Fenetre

    def initialize(menuParent)
        self.initialiseToi

<<<<<<< HEAD
        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/apropos.glade")
=======
        @builder = Gtk::Builder.new(:file => 'glade/aPropos.glade')
        @object = @builder.get_object("menuAPropos")

        @btnRetour = @builder.get_object("btnRetour")
>>>>>>> parent of a859fb0 (sauvegarde partie (en jeu))

        @menuParent = menuParent
    end
end