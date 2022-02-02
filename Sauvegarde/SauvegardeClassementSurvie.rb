load "SauvegardeClassement.rb"

class SauvegardeClassementSurvie < SauvegardeClassement

    attr_accessor :tabScore, :nbScoreOccupe

	def initialize()
        if(!File.exist?("./SauvegardeScore/scoreSurvie.yml"))
            @tabScore = Array.new(10)
            @nbScoreOccupe = 0; 
            File.open("./SauvegardeScore/scoreSurvie.yml", "w") { |file| file.write(tabScore.to_yaml) }
        else
            @tabScore = YAML.load(File.read("./SauvegardeScore/scoreSurvie.yml"))
            @nbScoreOccupe = self.getNbScoreOccupe
        end
    end

    def ajoutScore(unScore)
        super(unScore)
        File.open("./SauvegardeScore/scoreSurvie.yml", "w") { |file| file.write(@tabScore.to_yaml) }
    end

    def afficheToi()
        super("../glade/survie_nouvelle_partie.glade")
    end

end

classementSurvie = SauvegardeClassementSurvie.new
profil = Profil.new("Léo")
score1 = Score.new(50, profil)


classementSurvie.ajoutScore(score1)

classementSurvie.afficheToi()
