require 'gtk3'
include Gtk

load "Interfaces/Fenetre.rb"

=begin

    La classe FenetreAPropos :::
        - permet de générer l'interface "À propos" du jeu

    Les VI de la classe sont :::
        - @builder      ==> builder contenant la fenêtre courante (ici la fenêtre "à propos")
        - @object       ==> contient l'identifiant de l'interface
        - @btnRetour    ==> contient l'identifiant du bouton retour
        - @menuParent   ==> contient le fenêtre parente de la fenêtre courante

    Voici ses methodes :::
        - gestionSignaux : permet de gerer les signaux des objets du buildeur

=end

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