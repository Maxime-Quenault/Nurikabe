# ATTENTION : CLASSE NON OFFICIELLE #

class Grille
    @grille
    @identifiant
    @@id

    attr_accessor :grille, :identifiant
    def initialize()
        @grille = "je suis une grille"
        @identifant = @@id
        @@id += 1
    end

    def remplirGrille(uneChaine))
        @grille += uneChaine
    end

    def to_s()
        @grille
    end
end