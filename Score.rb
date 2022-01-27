
class Score
    attr_accessor :heures, :minutes, :secondes

    def initialize(unTemps)
        @heures = unTemps/3600
        unTemps = unTemps%3600

        @minutes = unTemps/60
        unTemps = unTemps%60

        @secondes = unTemps
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
        "#{@heures}h#{@minutes}m#{@secondes}s"
    end
end

## TEST UNITAIRE ##

#unScore = Score.new(458)
#print unScore
#print "\n"
#p unScore.getTempsEnSecondes