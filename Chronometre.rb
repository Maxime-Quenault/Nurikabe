# Représente le Chrono du Nurikabe
class Chronometre

    private_class_method :new

    # temps restant ou temps en cours
    @temps
    # indiquant si le jeu est en pause
    @pause

    attr_reader :temps, :pause

    # Constructeur du Chronomètre
    def Chronometre.creer()
        new()
    end

    # initialize le chronomètre avec un temps à 0
    def initialize()
        @temps = 0
        @pause = false

        @debut = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    end 

    # méthode incrémentant le temps total du chronometre
    def top()
        if(!self.estEnPause?())
            fin = Process.clock_gettime(Process::CLOCK_MONOTONIC)
            @temps = @temps + (@debut - fin)
            @debut = fin 
        end

        if(@temps < 0)
            @temps = 0
        end

        #return estNul?()
    end

    # renvoie si le temps est nul 
    def estNul?()
        return @temps == 0 
    end

    # renvoie si le jeu en pause
    def estEnPause?()
        return @pause == true
    end

    # actionne le chronometre
    def demarre()
        self.enlevePause()
        @debut = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        top()
    end

    # met en pause le jeu
    def metEnPause()
        top()
        @pause = true 
    end

    # enleve la pause
    def enlevePause()
        @pause = false 
    end

    # retourne le temps sous la forme float
    def getTemps()
        top()
        return @temps
    end

    # augmente le temps par un malus
    def ajouteTemps(unMalus)
        @temps += unMalus 
    end 

    # retourne le temps arrondi au dessous sous la forme de String
=begin    def getTempsString()
        top()
        return format("%01d",(@temps.floor/60).to_s) + ":" + format("%02d",(@temps.floor%60).to_s)
    end
=end
end
