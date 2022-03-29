class Score
    attr_accessor :heures, :minutes, :secondes, :profil

    def initialize(unTemps, unProfil)
        @heures = unTemps/3600
        unTemps = unTemps%3600

        @minutes = unTemps/60
        unTemps = unTemps%60

        @secondes = unTemps

        @profil = unProfil
    end

    def getHeures
        @heures
    end

    def getMinutes
        @minutes
    end

    def getSecondes
        @secondes
    end

    def getTempsEnSecondes
        unTemps = @secondes + (@minutes * 60) + (@heures * 3600)
    end


    def to_s
        "#{self.getTempsEnSecondes}"
    end
end