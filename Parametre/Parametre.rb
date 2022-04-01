##
# Auteurs Sanna Scherrer
# Version 0.2 : Date : Mon Jan 24 15:30:00 CET 2022
#
####

=begin
	La classe Parametre permet de :::
        - Choisir le thème du jeu (sombre ou clair).
        - Choisir les couleurs pour l'interface.
        - Autoriser ou non les effets sonores.
        - Choisir la langue du jeu.

    Les VI de la classe sont :::
        - themeSombre   ==> le thème est initialisé à "light" par défaut
        - couleur       ==> couleur des iles et des points
=end

class Parametre

    ##
    # Accès en lecture aux paramètres : themeSombre, couleur
    attr_accessor :themeSombre, :couleur,
    
    ##
    # Méthode d'initialisation de la classe Paramètre
    # Les valeurs sont initialisées par défaut
    def initialize()
        @themeSombre = false
        @couleur = '\#000000'
    end
end