##
#   @author Quenault Maxime
#
#   Cette classe permet de gerer les scores du mode Contre la Montre, un score est un temps en seconde.
#
#   Voici ses méthodes :
#   
#   - getHeures : permet d'obtenir le nombre d'heures du score
#   - getMinutes : permet d'obtenir le nombre de minutes du score
#   - getSecondes : permet d'obtenir le nombre de secondes du score
#   - getTempsEnSecondes : permet d'obtenir le score complet en seconde
#   - to_s : affiche le score en seconde
#   
#   Voici ses VI :
#
#   - @heures : representes le nombre d'heure
#   - @minutes : representes le nombre de minutes
#   - @secondes : representes le nombre de secondes
#   - @profil : representes le profil auquel appartient le score


class Score

    attr_accessor :profil

    def initialize(unTemps, unProfil)
        @heures = unTemps/3600
        unTemps = unTemps%3600

        @minutes = unTemps/60
        unTemps = unTemps%60

        @secondes = unTemps

        @profil = unProfil
    end

    ##
    # getHeures:
    #   permet d'obtenir le nombre d'heures du score
    def getHeures
        @heures
    end

    ##
    # getMinutes:
    #   permet d'obtenir le nombre de minutes du score
    def getMinutes
        @minutes
    end

    ##
    # getSecondes:
    #   permet d'obtenir le nombre de secondes du score
    def getSecondes
        @secondes
    end

    ##
    # getTempsEnSecondes:
    #   permet d'obtenir le score complet en seconde 
    def getTempsEnSecondes
        unTemps = @secondes + (@minutes * 60) + (@heures * 3600)
    end

    ##
    # to_s:
    #   affiche le score en seconde
    def to_s
        "#{self.getTempsEnSecondes}"
    end
end