load "Parametre.rb"
class Profil
    attr_accessor :pseudo, :parametre

    def initialize(unPseudo)
        @pseudo = unPseudo
        @parametre = Parametre.new()
    end

    def to_string()
        "mon pseudo : #{@pseudo}, mes parametres : #{@parametre}"
    end
end
