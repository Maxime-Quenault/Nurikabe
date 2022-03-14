load "Partie/Grille.rb"
class Profil
    attr_accessor :pseudo, :parametre, :listeGrilleCommence, :imageJoueur

    def initialize(unPseudo)
        @imageJoueur = "Image/user.png"
        @pseudo = unPseudo
        @parametre = Parametre.new()
        @listeGrilleCommence = []
        if(!File.exist?("Sauvegarde/SauvegardeGrille/listeGrille#{@pseudo}.dump"))
            @listeGrilleCommence = Array.new
        else  
            @listeGrilleCommence = Marshal.load(File.binread("Sauvegarde/SauvegardeGrille/listeGrille#{@pseudo}.dump"))
        end
    end

<<<<<<< HEAD
    def ajouterGrille(uneGrille)
        @listeGrilleCommence.push(uneGrille)
        File.open("Sauvegarde/SauvegardeGrille/listeGrille#{@pseudo}.dump", "wb") { |file| file.write(Marshal.dump(@listeGrilleCommence)) }
    end

    def chercherGrille(numero)
        @listeGrilleCommence.each do |key, value|
=======
    def ajouterPartie(unePartie)
        @listePartieCommence.push(uneGrille)
        File.open("Sauvegarde/SauvegardeGrille/listeGrille#{@pseudo}.dump", "wb") { |file| file.write(Marshal.dump(@listePartieCommence)) }
    end

    def chercherPartie(numero)
        @listePartieCommence.each do |key, value|
>>>>>>> parent of a859fb0 (sauvegarde partie (en jeu))
            if key.numero == numero
                return key
            end
        end
        return nil
    end

    def to_s()
        pseudo
    end
end

