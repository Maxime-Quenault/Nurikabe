require "yaml.rb"
load "Profil.rb"

class SauvegardeProfil


    attr_accessor :listeProfil, :profil
    
    def initialize()
        if(!File.exist?("./SauvegardeProfil/listeProfil.yml"))
            @listeProfil = Array.new
        else  
            @listeProfil = YAML.load(File.read("./SauvegardeProfil/listeProfil.yml"))
        end
    end

    def ajoutProfil(unProfil)
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                return
            end
        end
        print "\n\nunProfil : #{unProfil}"
        @listeProfil.push(unProfil)    
        File.open("./SauvegardeProfil/listeProfil.yml", "w") { |file| file.write(listeProfil.to_yaml) }
        @listeProfil = YAML.load(File.read("./SauvegardeProfil/listeProfil.yml"))
    end

    def supprimerProfil(unProfil)
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                @listeProfil.delete(key)    
                File.open("./SauvegardeProfil/listeProfil.yml", "w") { |file| file.write(listeProfil.to_yaml) }
                @listeProfil = YAML.load(File.read("./SauvegardeProfil/listeProfil.yml"))
            end
        end
    end

    def chargerProfil(unPseudo)
        @listeProfil.each do |key, value|
            if(key.pseudo == unPseudo)
                return key
            end
        end
    end
end

test = SauvegardeProfil.new()
profil1 = Profil.new("Maxime")
test.ajoutProfil(profil1)
profil2 = Profil.new("Leo")
test.ajoutProfil(profil2)