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

	4 Variables d'instance :::
        - Parametre.themeSombre : Thème actuel.
        - Parametre.couleur : Couleur des cases remplies en jeu.
        - Parametre.effetSonore : Autorisation ou non des effets sonores.
        - Parametre.langue : Langue actuellement sélectionnée.
=end

class Parametre

    ##
    # Accès en lecture aux paramètres : themeSombre, couleur, effets_sonores, langue
    attr_accessor :themeSombre, :couleur, :effetSonore, :langue
    
    ##
    # Méthode d'initialisation de la classe Paramètre
    # Les valeurs sont initialisées par défaut
    def initialize()
        @themeSombre = false
        @couleur = '\#000000'
        @effetSonore = false
        @langue = 'fr'
    end

    ##
    # Méthode de réinitialisation des paramètres
    def resetParametre()
        @themeSombre = false
        @couleur = '\#000000'
        @effetSonore = false
        @langue = 'fr'
    end    


    ##
    # Redéfinition de la méthode to_s afin d'afficher les données de la classe 
    def to_s()
        return "Thème = #{@themeSombre} \nCouleur = #{@couleur} \nEffets sonores = #{@effetSonore} \nLangue = #{@langue}\n"
    end
end