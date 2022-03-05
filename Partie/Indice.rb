# Un indice est défini par un type d'indice (en fonction des différents patternes) et par les coordonnées de la case concernée
class Indice
    @type
    @coordonneesCase

    # Différents types possibles
    :ile1NonEntouree
    :ilesDiagonalesNonSeparees
    :ilesVoisinesNonSeparees
    :ocean2x2
    :caseJouableIsolee
    :expansionMur
    :expansionIle


    def Indice.creer(t,c)
		new(t,c)
	end
	private_class_method :new
	def initialize(t,c)
		@type=t
        @coordonneesCase=c
	end
    attr :type, false
    attr :coordonneesCase, false

    #affichage d'un indice
    def to_s()
        if self.type==nil
            return "Pas d'indice disponible"
        end
        res = ""
        case @type
        when :ile1NonEntouree
            res=res+"Une île de valeur 1 n'est pas entourée de cases Océan"
        when :ilesDiagonalesNonSeparees
            res=res+"Des cases île en diagonales ne sont pas séparées par des cases Océan"
        when :ilesVoisinesNonSeparees
            res=res+"Des cases voisines ne sont pas séparées par une case Océan"
        when :ocean2x2
            res=res+"Il y a un carré de cases Océan de taille 2 * 2"
        when :caseJouableIsolee
            res=res+"Il y a une case Jouable qui est isolée"
        when :expansionMur
            res=res+"On peut étendre le mur avec une case Océan"
        when :expansionIle
            res=res+"On peut étendre l'île avec une case île"
        else
            res=res+"Pas d'indice trouvé"
        end
        if @coordonneesCase!=nil
            res=res+" aux coordonnées x = #{@coordonneesCase[0]} y = #{@coordonneesCase[1]}" 
        end
        return res
    end

end