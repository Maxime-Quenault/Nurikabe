=begin

    La classe Chronomètre :::
        - permet de gérer le chronomètre de la partie
    
    Les VI de la classe sont :::

        - @temps    ==> temps restant ou temps en cours
        - @pause    ==> boolean indiquant si le jeu est en pause ou non
        - @sens     ==> le sens du temps (augmente ou diminue en fonction du mode de jeu)

=end

class Chronometre

    private_class_method :new

    @temps
    @pause
    @sens

    attr_reader :temps, :pause, :sens

    # On définit notre propre façon de gérer un Chronomètre
    def Chronometre.creer(unTemps, unSens)
        new(unTemps, unSens)
    end

    # la méthode initialize() gère le chronomètre suivant les critères du mode de jeu
    def initialize(unTemps, unSens)
        @temps = unTemps
        @pause = false
        @sens = unSens 

        @debut = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    end 

    #
    def top()

    end

    # renvoie si le temps est nul 
    def estNul?()
        return @temps == 0 
    end

    # 
    def demarre()
        enlevePause()
        
    end

    # met en pause le jeu
    def metEnPause()
        @pause = true 
        # met en pause le temps 
    end

    # enleve la pause
    def enlevePause()
        @pause = false 
    end

    # retourne le temps
    def getTemps()
        return @temps
    end

end