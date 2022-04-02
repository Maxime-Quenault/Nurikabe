load "Sauvegarde/Profil.rb"
load "Parametre/Parametre.rb"
load "Partie/Grille.rb"

require 'gtk3'
include Gtk

##
#   @author Quenault Maxime / Trottier Leo
#
#   Cette classe permet de gerer la sauvegarde des profil dans un fichier marchal.
#
#   Voici ses methodes :
#
#   - ajoutProfil : permet d'ajouter un profil à la liste de profil
#   - suppAllProfil : permet de supprimer tous les profils de la liste
#   - supprimerProfil : permet de supprimer un profil de la liste
#   - getNbProfil : permet de recuperer le nombre de profil sauvegardé
#   - chargerProfil : permet de charger un profil
#   - changerParametre : permet de mettre à jour les parametre du profil
#   - modifierAvatar : permet de mettre à jour l'avatar du profil
#   - sauvegarder : permet de sauvegarder le profil actuelle (mettre a jour la liste)
#
#   Voici ses VI :
#
#   - @listeProfil : represente la liste des profils sauvegardé
#   - @nbProfil : represente le nombre de profil sauvegardé

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

    ##
    # ajoutProfil:
    #   permet d'ajouter un profil à la liste de profil
    #
    # @param unProfil represente le profil à ajouter
    def ajoutProfil(unProfil)
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                return -1
            end
        end
        @listeProfil.push(unProfil)    
        File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
        @listeProfil = Marshal.load(File.binread("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
        @nbProfil = @nbProfil + 1
        return 1
    end

    ##
    # suppAllProfil
    #   permet de supprimer tous les profils de la liste
    def suppAllProfil
        @listeProfil.each do |key, value|
            supprimerProfil(key)
        end
    end

    ##
    # supprimerProfil
    #   permet de supprimer un profil de la liste
    #
    # @param unProfil represente le profil a supprimer
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

    ##
    # getNbProfil
    #   permet de recuperer le nombre de profil sauvegardé
    def getNbProfil
        nombre = 0
        @listeProfil.each do |key, value|
            nombre = nombre + 1
        end
        nombre
    end

    ##
    # chargerProfil:
    #   permet de charger un profil
    #
    # @param unPseudo represente le pseudo du profil à charger
    def chargerProfil(unPseudo)
        @listeProfil.each do |key, value|
            if(key.pseudo == unPseudo)
                return key
            end
        end
        return -1
    end

    ##
    # changerParametre:
    #   permet de mettre à jour les parametre du profil
    #
    # @param unProfil represente le profil dont les parametre doivent être changé
    def changerParametre(unProfil)
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                key = unProfil
            end
        end
        File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
    end

    ##
    # modifierAvatar:
    #   permet de mettre à jour l'avatar du profil
    #
    # @param uneImage represente le lien de l'image pour le nouvel avatar du profil
    # @param profilActuel represente le profil dont l'avatar doit être mis à jour
    def modifierAvatar(uneImage, profilActuel)
        @listeProfil.each do |key, value|
            if key.pseudo == profilActuel.pseudo
                key.imageJoueur = uneImage                
            end
            File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
        end
    end

    ##
    # sauvegarde:
    #   permet de sauvegarder un profil
    #
    # @param unProfil represente le profil qui doit être suavergardé
    def sauvegarder(unProfil)
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                key = unProfil
            end
        end
        File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
    end

end