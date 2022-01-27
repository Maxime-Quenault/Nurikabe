class SauvegardeClassementSurvie
    attr_accessor :listeScore

    def initialize()
        if(!File.exist?("./SauvegardeScore/scoreSurvie.yml"))
            @listeScore = Array.new
        else
            @listeScore = YAML.load(File.read("./SauvegardeScore/scoreSurvie.yml"))
        end
    end

    def ajoutScore(unScore)
        @listeScore.push(unScore).sort
    end

end