require "yaml.rb"

class SauvegardeProfil


    attr_accessor :listeProfil
    
    def initialize()
        if(!File.exist?("./SauvegardeProfil/listeProfil.yml"))
            @listeProfil = Array.new
        else  
            @listeProfil = YAML.load(File.read("./SauvegardeProfil/listeProfil.yml"))
        end
    end

    def creerProfil(unPseudo)
        if(!@listeProfil.include?(unPseudo))
            @listeProfil.push(unPseudo)
            File.open("./SauvegardeProfil/listeProfil.yml", "w") { |file| file.write(listeProfil.to_yaml) }
        else
            print "profil déjà existant\n"
        end
    end

    def supprimerProfil(unPseudo)
        if(@listeProfil.include?(unPseudo))
            @listeProfil.delete(unPseudo)
            File.open("./SauvegardeProfil/listeProfil.yml", "w") { |file| file.write(listeProfil.to_yaml) }
        else
            print "le profil n'existe pas\n"
        end
    end

    def index?(unPseudo)
        @listeProfil.index(unPseudo)
    end

    def chargerProfil()

    end

end

test = SauvegardeProfil.new()
test.creerProfil("Maxime")
test.creerProfil("Leo")
test.supprimerProfil("Test")
print test.index?("Maxime")
print test.index?("Leo")
p test.listeProfil