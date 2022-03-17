load "Sauvegarde/Profil.rb"
load "Parametre/Parametre.rb"
load "Partie/Grille.rb"

require 'gtk3'
include Gtk

class SauvegardeProfil


    attr_accessor :listeProfil, :nbProfil
    
    def initialize()
        if(!File.exist?("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
            @listeProfil = Array.new
            @nbProfil = 0
        else  
            @listeProfil = Marshal.load(File.binread("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
            @nbProfil = self.getNbProfil
        end
    end

    def ajoutProfil(unProfil)
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                return -1
            end
        end
        print "\n\nunProfil : #{unProfil}"
        @listeProfil.push(unProfil)    
        File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
        @listeProfil = Marshal.load(File.binread("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
        @nbProfil = @nbProfil + 1
        return 1
    end

    def suppAllProfil
        @listeProfil.each do |key, value|
            supprimerProfil(key)
        end
        print @listeProfil
    end

    def supprimerProfil(unProfil)
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                @listeProfil.delete(key)    
                File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
                @listeProfil = Marshal.load(File.binread("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
                @nbProfil = @nbProfil - 1
            end
        end
        
    end

    def getNbProfil
        nombre = 0
        @listeProfil.each do |key, value|
            nombre = nombre + 1
        end
        nombre
    end

    def chargerProfil(unPseudo)
        @listeProfil.each do |key, value|
            if(key.pseudo == unPseudo)
                return key
            end
        end
        return -1
    end

    def modifierPseudo(unPseudo, profilActuel)
        @listeProfil.each do |key, value|
            if(key.pseudo == unPseudo)
                return false
            end
        end
        @listeProfil.each do |key, value|
            if key.pseudo == profilActuel.pseudo 
                key.pseudo = unPseudo                   
            end
            File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
            @listeProfil = Marshal.load(File.binread("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
        end
        return true
    end

    def changerParametre(unProfil)
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                key = unProfil
            end
        end
        File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
    end

    def sauvegarder(unProfil, unePartie)
        if unePartie != nil
            uneProfil.ajouterPartie(unePartie)
        end
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                key = unProfil
            end
        end
        File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
    end

end