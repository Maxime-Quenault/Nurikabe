#!/usr/bin/ruby
require 'gtk3'
load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"
load "Parametre/Parametre.rb"
load "Interfaces/FenetreMenu.rb"


=begin

    La classe jeu :::
        - permet de lancer le jeu avec toutes les fonctionnalités
    
    Les VI de la classe sont :::
        - @interface    ==> interface courante
        - @quit         ==> booleen indiquant si la fenêtre est fermée ou pas

=end

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
