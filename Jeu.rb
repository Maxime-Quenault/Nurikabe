load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"
load "Parametre/Parametre.rb"
load "InterfaceMenu.rb"

class Jeu

    def initialize

        @interface = InterfaceMenu.new

    end

    def lanceToi

        save = SauvegardeProfil.new
        unProfil = save.afficherSauvegarde
        @interface.afficheToi
    end

end

unJeu = Jeu.new
unJeu.lanceToi
