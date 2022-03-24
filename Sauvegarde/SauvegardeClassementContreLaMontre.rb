require "yaml.rb"
require 'gtk3'
include Gtk
load "Sauvegarde/Score.rb"
load "Sauvegarde/SauvegardeProfil.rb"

class SauvegardeClassementContreLaMontre

    attr_accessor :tabScore, :nbScoreOccupe

    def initialize(numGrille)
        @numeroGrille = numGrille

        print "\n"
        print @numeroGrille
        print "\n"

        if(!File.exist?("Sauvegarde/SauvegardeScore/scoreContreLaMontre#{@numeroGrille}.dump"))
            @tabScore = Array.new(10)
            @nbScoreOccupe = 0; 
            File.open("Sauvegarde/SauvegardeScore/scoreContreLaMontre#{@numeroGrille}.dump", "wb") { |file| file.write(Marshal.dump(@tabScore)) }
        else
            @tabScore = Marshal.load(File.binread("Sauvegarde/SauvegardeScore/scoreContreLaMontre#{@numeroGrille}.dump"))
            @nbScoreOccupe = self.getNbScoreOccupe
        end
    end

        #
    # ici quand j'ajoute un score je trie le tableau des scores en même temps
    # ce qui permet de toujours garder un tableau de score de 10 de longueur et des scores toujours triés
    #
    def ajoutScore(unScore)
        tabTampon = Array.new(10)
        i = 0
        flagAjoute = 0

        # Parcours tous les scores et insert le score en fonction des autres
        while i < nbScoreOccupe && flagAjoute == 0
        	if unScore.getTempsEnSecondes.to_f < @tabScore[i].getTempsEnSecondes.to_f
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

        File.open("Sauvegarde/SauvegardeScore/scoreContreLaMontre#{@numeroGrille}.dump", "wb") { |file| file.write(Marshal.dump(@tabScore)) }
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
