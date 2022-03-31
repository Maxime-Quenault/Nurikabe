=begin
    @author Julian LEBOUC
    La classe Indice :::
        - représente un indice, lui même représenté par
            - un type (différent selon les différents patrons)
            - les coordonnées de la case concernée
    
    Les VI de la classe sont :::

        - @type             ==> type de l'indice
        - @coordonneesCase  ==> coordonnées de la case, tableau de deux entiers [x,y]

=end

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
    ##
    # Constructeur affectant aux variables @type et @coordonneesCase les valeurs passées en paramètres
	def initialize(t,c)
		@type=t
        @coordonneesCase=c
	end
    attr :type, false
    attr :coordonneesCase, false

    ##
    # Retournes un texte décrivant l'indice
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
            res=res+"On peut étendre un mur avec une case Océan"
        when :expansionIle
            res=res+"On peut étendre une île avec une case île"
        else
            res=res+"Pas d'indice trouvé"
        end
        if @coordonneesCase!=nil
            #res=res+" aux coordonnées x = #{@coordonneesCase[0]} y = #{@coordonneesCase[1]}" 
        end
        return res
    end

    ##
    # méthode de comparaison des indices selon leur type et coordonnées
    def ==(indice)
        if indice!=nil && indice.type!=nil
            return @type == indice.type && @coordonneesCase[0] == indice.coordonneesCase[0] && @coordonneesCase[1] == indice.coordonneesCase[1]
        else
            return false
        end
    end
end