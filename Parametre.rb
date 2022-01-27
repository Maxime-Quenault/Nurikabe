# ATTENTION : CLASSE NON OFFICIELLE #

class Parametre
    @langue
    @couleur
    
    def initialize()
        @langue = "fr"
        @couleur = "noir"
    end

    def setLangue(uneLangue)
        @langue = uneLangue
    end

    def setCouleur(uneCouleur)
        @couleur = uneCouleur
    end

    def to_s
        "{langue \"#{@langue}\" / couleur \"#{@couleur}\"}"
    end
end