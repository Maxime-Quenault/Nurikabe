require 'gtk3'
include Gtk

load "Sauvegarde/Profil.rb"

class FenetreAPropos

    attr_accessor :profil, :quit
    def initialize(menuParent)
        @quit = false
        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/apropos.glade")

        @menuParent = menuParent
    end
end