load "Chrono/Chronometre.rb"

# Chrono qui decompte son temps pour les modes de jeu Survie
class ChronometreSurvie < Chronometre

    # Constante du temps de départ du Chronometre
    CHRONOMETRE_BASE_TEMPS = 300

    def ChronometreSurvie.creer()
        new()
    end

    # initialize le chronomètre avec un temps prédéfini
    def initialize()
        super()
        @temps = CHRONOMETRE_BASE_TEMPS
    end

    # méthode décrémentant le temps total du chrono
    def top()
        if(!self.estEnPause?())
            fin = Time.now
            @temps = @temps - (fin - @debut)
            @debut = fin 
        end

        if(@temps < 0)
            @temps = 0
        end
    end

    # augmente le temps par un bonus
    def ajouteTemps(unBonus)
        @temps+=unBonus
    end

    # diminue le temps par un malus 
    def retireTemps(unMalus)
        @temps -= unMalus
    end
end
