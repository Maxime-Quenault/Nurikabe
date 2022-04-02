load "Sauvegarde/Score.rb"
load "Sauvegarde/SauvegardeProfil.rb"

##
#   @author Trottier Leo / Quenault Maxime
#
#   Cette classe permet de sauvegarder les 10 meilleurs temps d'une difficulte du mode de jeu "Survie".
#
#   Voici ses methodes :
#
#   - ajoutScore : permet d'ajouter dynamiquement un score dans le tableau des scores en conservant le top 10
#   - getNbScoreOccupe : permet d'obtenir le nombre de score déjà enregistré
#
#   Voici ses VI :
#
#   - @difficulte : represente le numero de la grille à qui appartient le tableau des scores
#   - @tabScore : represente le tableau des scores (fichier marchall)
#   - @nbScoreOccupe : represente le nombre de scores déjà présent dans le tableau des scores

class SauvegardeClassementSurvie

    attr_accessor :tabScore, :nbScoreOccupe

    def initialize(difficulte)
        @difficulte = difficulte

        if(!File.exist?("Sauvegarde/SauvegardeScore/scoreSurvie#{@difficulte}.dump"))
            @tabScore = Array.new(10)
            @nbScoreOccupe = 0; 
            File.open("Sauvegarde/SauvegardeScore/scoreSurvie#{@difficulte}.dump", "wb") { |file| file.write(Marshal.dump(@tabScore)) }
        else
            @tabScore = Marshal.load(File.binread("Sauvegarde/SauvegardeScore/scoreSurvie#{@difficulte}.dump"))
            @nbScoreOccupe = self.getNbScoreOccupe
        end
    end

    ##
    # ajoutScore:
    #   ici quand j'ajoute un score je trie le tableau des scores en même temps
    #   ce qui permet de toujours garder un tableau de score de 10 de longueur et des scores toujours triés
    #
    # @param unScore represente le score à ajouter au tableau des scores
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

        File.open("Sauvegarde/SauvegardeScore/scoreSurvie#{@difficulte}.dump", "wb") { |file| file.write(Marshal.dump(@tabScore)) }

    end

    ##
    # getNbScoreOccupe:
    #   permet d'obtenir le nombre de score déjà enregistré
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
