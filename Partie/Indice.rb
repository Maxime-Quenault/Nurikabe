class Indice
    @type
    @coordonneesCase

   
    :ile1NonEntouree
    :ilesDiagonalesNonSeparees
    :ilesVoisinesNonSeparees
    :ocean2x2


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

    def to_s()
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
        else
            res=res+"Pas d'indice trouvé"
        end
        if @coordonneesCase!=nil
            res=res+" aux coordonnées x = #{@coordonneesCase[0]} y = #{@coordonneesCase[1]}" 
        end
        return res
    end

end