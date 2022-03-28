require 'gtk3'
include Gtk

load "./Partie/Partie.rb"
load "./Interfaces/Fenetre.rb"
load "Interfaces/FenetreGrille.rb"

class FenetreGrilleSurvie < FenetreGrille
    @fenetreClassement
    attr_accessor :object

    def initialize(menuParent, fenetreClassement)
        super(menuParent)
        @fenetreClassement=fenetreClassement
    end
end