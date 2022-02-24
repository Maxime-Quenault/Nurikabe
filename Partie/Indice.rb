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

end