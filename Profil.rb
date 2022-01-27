load "Parametre.rb"
class Profil
    attr_accessor :pseudo, :parametre, :listeGrilleCommence

    def initialize(unPseudo)
        @pseudo = unPseudo
        @parametre = Parametre.new()
        @listeGrilleCommence = []
    end

    
    def to_s()
        "mon pseudo : #{@pseudo}, mes parametres : #{@parametre}"
    end
end
