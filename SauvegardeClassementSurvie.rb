class SauvegardeClassementSurvie
    attr_accessor :listeTemps

    def initialize()
        if(!File.exist?("./SauvegardeScore/scoreSurvie.yml"))
            @listeTemps = Array.new
        else
            @listeTemps = YAML.load(File.read("./SauvegardeScore/scoreSurvie.yml"))
        end
    end

    def ajoutTemps(unTemps)
        @listeTemps = YAML.load(File.read("./SauvegardeScore/scoreSurvie.yml"))
        @listeTemps.push(unTemps).sort
        File.open("./SauvegardeScore/scoreSurvie.yml", "w") { |file| file.write(listeTemps.to_yaml) }
    end

end