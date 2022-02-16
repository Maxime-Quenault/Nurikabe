load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"
load "Parametre/Parametre.rb"
load "Interfaces/FenetreMenu.rb"

class Jeu

    def lanceToi
        interface = FenetreMenu.new
        print interface.profil
        print "test\n"
        interface.afficheToi
    end

end

unJeu = Jeu.new
unJeu.lanceToi
