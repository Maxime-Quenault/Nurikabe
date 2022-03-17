load "Partie/Grille.rb"
class Profil
    attr_accessor :pseudo, :parametre, :listePartieCommence, :imageJoueur

    def initialize(unPseudo)
        @imageJoueur = "Image/user.png"
        @pseudo = unPseudo
        @parametre = Parametre.new()
        @listePartieCommence = []
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
        if difficulte == 0
            hauteur = 8
        elsif difficulte ==1
            hauteur = 10
        end
        @listePartieCommence.each do |key, value|
            if key.grilleEnCours.numero == numero && key.grilleEnCours.hauteur == hauteur
                return key
            end
        end
        return nil
    end

    def to_s()
        pseudo
    end
end

