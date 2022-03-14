#!/usr/bin/ruby
require 'gtk3'
load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"
load "Parametre/Parametre.rb"
load "Interfaces/FenetreMenu.rb"

class Jeu

    attr_accessor :quit
    def initialize
        @interface = FenetreMenu.new
        @quit = false
        if @interface.quit
            @quit = true
        end
    end

    def lanceToi
        @interface.changerInterface(@interface.object, "Menu")
        Gtk.main
    end

end

unJeu = Jeu.new
if !unJeu.quit
    unJeu.lanceToi
end
