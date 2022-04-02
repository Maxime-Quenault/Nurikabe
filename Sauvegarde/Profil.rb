load "Partie/Grille.rb"
load "Aventure/Aventure.rb"

##
#   @author Trottier Leo / Quenault Maxime
#
#   Cette classe permet de gerer les profils.
#
#   Voici ses méthodes :
#
#   - ajouterPartie : permet d'ajouter une partie dans la liste des partie déjà commencé par un profils
#   - chercherPartie : permet de chercher une partie pour savoir si elle a déjà été commencé ou non
#   - to_s : permet d'afficher un profil par son pseudo
#
#   Voici ses VI :
#
#   - @imageJoueur : represente le chemin d'accès à l'avatar du profil
#   - @pseudo : represente le pseudo du profil
#   - @parametre : represente les parametre du profil
#   - @listePartieCommence : represente une liste de toute les partie commencé par le profil



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

    ##
    # ajouterPartie:
    #   permet d'ajouter une partie dans la liste des partie déjà commencé par un profils
    #
    # @param unPartie represente la partie à ajouter à la liste
    def ajouterPartie(unePartie)
        @listePartieCommence.push(unePartie)
        File.open("Sauvegarde/SauvegardeGrille/listeGrille#{@pseudo}.dump", "wb") { |file| file.write(Marshal.dump(@listePartieCommence)) }
    end

    ##
    # chercherPartie:
    #   permet de chercher une partie pour savoir si elle a déjà été commencé ou non
    #
    # @param numero represente l'indentifiant de la grille
    # @param difficulte represente la difficulté de la grille
    def chercherPartie(numero, difficulte)
        @listePartieCommence.each do |key, value|
            if key.grilleEnCours.numero == numero && key.grilleEnCours.difficulte==difficulte
                return key
            end
        end
        return nil
    end

    ##
    # to_s:
    #   affiche le pseudo du profil
    def to_s
        pseudo
    end
end

