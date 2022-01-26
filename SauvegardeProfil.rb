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
        if(key == "pseudo")
            if(value != unProfil.pseudo)
                @listeProfil.push(unProfil)
                system 'mkdir', '-p', "./SauvegardeProfil/#{unProfil.pseudo}"
                File.open("./SauvegardeProfil/listeProfil.yml", "w") { |file| file.write(listeProfil.to_yaml) }
                @listeProfil = YAML.load(File.read("./SauvegardeProfil/listeProfil.yml"))
            else
                print "profil déjà existant\n"
        end
    end

    def supprimerProfil(unProfil)
        if(@listeProfil.include?(unProfil))
            @listeProfil.delete(unProfil)
            system 'rmdir', "./SauvegardeProfil/#{unProfil.pseudo}"
            File.open("./SauvegardeProfil/listeProfil.yml", "w") { |file| file.write(listeProfil.to_yaml) }
            @listeProfil = YAML.load(File.read("./SauvegardeProfil/listeProfil.yml"))
        else
            print "le profil n'existe pas\n"
        end
    end
end

test = SauvegardeProfil.new()
profil1 = Profil.new("Maxime")
test.ajoutProfil(profil1)
profil2 = Profil.new("Leo")
test.ajoutProfil(profil2)
print test.index?("Maxime")
print "\n"
print test.index?("Leo")
print "\n"
p test.listeProfil