load "Sauvegarde/Score.rb"
load "Sauvegarde/SauvegardeProfil.rb"

class SauvegardeClassementSurvie

    attr_accessor :tabScore, :nbScoreOccupe

    def initialize(numGrille)
        @numeroGrille = numGrille

        if(!File.exist?("Sauvegarde/SauvegardeScore/scoreSurvie#{@numeroGrille}.dump"))
            @tabScore = Array.new(10)
            @nbScoreOccupe = 0; 
            File.open("Sauvegarde/SauvegardeScore/scoreSurvie#{@numeroGrille}.dump", "wb") { |file| file.write(Marshal.dump(@tabScore)) }
        else
            @tabScore = Marshal.load(File.binread("Sauvegarde/SauvegardeScore/scoreSurvie#{@numeroGrille}.dump"))
            @nbScoreOccupe = self.getNbScoreOccupe
        end
    end

    def ajoutScore(unScore)
        i = 0
        flagAjoute = 0
        # Parcours tous les scores et insert le score en fonction des autres
        while i < nbScoreOccupe && flagAjoute == 0
        	if unScore.getTempsEnSecondes > @tabScore[i].getTempsEnSecondes
        		@tabScore.insert(i, unScore)
                if self.getNbScoreOccupe() > 10 # Il vérifie le nombre de score occupé, si c'est > 10, il faut alors supprimer le 11ème qui est le plus nul
                    @tabScore.delete_at(10)
                end
        		flagAjoute = 1
        	else
                i += 1
        	end            
        end
        
        # Ajoute le score si il reste de la place (puisque c'est le moins bon)
        if flagAjoute == 0 && i < 10
            @tabScore.insert(i, unScore)
        end

        File.open("Sauvegarde/SauvegardeScore/scoreSurvie#{@numeroGrille}.dump", "wb") { |file| file.write(Marshal.dump(@tabScore)) }

    end

    def getNbScoreOccupe
        nombre = 0
        @tabScore.each do |key, value|
            if key != nil
                nombre = nombre + 1
            end
        end
        nombre
    end
end
