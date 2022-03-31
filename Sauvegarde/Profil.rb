load "Partie/Grille.rb"
load "Aventure/Aventure.rb"

class Profil
    attr_accessor :pseudo, :parametre, :listePartieCommence, :imageJoueur, :uneAventureFacile, :uneAventureMoyen, :uneAventureDifficile

    def initialize(unPseudo)
        @imageJoueur = "Image/utilisateur.png"
        @pseudo = unPseudo
        @parametre = Parametre.new()
        @listePartieCommence = []

        @uneAventureFacile = Aventure.creer(0)
        @uneAventureFacile.generationAventure(10, 0)

        @uneAventureMoyen = Aventure.creer(1)
        @uneAventureMoyen.generationAventure(10, 1)

        @uneAventureDifficile = Aventure.creer(2)
        @uneAventureDifficile.generationAventure(10, 2)
        
        if(!File.exist?("Sauvegarde/SauvegardeGrille/listeGrille#{@pseudo}.dump"))
            @listePartieCommence = Array.new
        else  
            @listePartieCommence = Marshal.load(File.binread("Sauvegarde/SauvegardeGrille/listeGrille#{@pseudo}.dump"))
        end
    end

    def ajouterPartie(unePartie)
        @listePartieCommence.push(unePartie)
        File.open("Sauvegarde/SauvegardeGrille/listeGrille#{@pseudo}.dump", "wb") { |file| file.write(Marshal.dump(@listePartieCommence)) }
    end

    def chercherPartie(numero, difficulte)
        @listePartieCommence.each do |key, value|
            if key.grilleEnCours.numero == numero && key.grilleEnCours.difficulte==difficulte
                return key
            end
        end
        return nil
    end

    def to_s()
        pseudo
    end
end

