# Représentes une case sur laquelle on peut cliquer
class CaseJouable
	# l'état indique si la case est une case île, océan ou non jouée
	@etat

	def CaseJouable.creer()
		new()
	end

	private_class_method :new
	attr :etat, true

	def initialize()
		@etat=0
	end

	#changes l'état de la case en fonction de son état courant
	def changerEtat()
		if(@etat==0)
			@etat=1
		elsif(@etat==1)
			@etat=2
		else
			@etat=0
		end
		return self
	end

	def to_s
		if @etat==0 then
			print "."
		elsif @etat==1 then
			print "x"
		else
			print "o"
		end
	end

	def <=>(c)
		return @etat<=>c.etat
	end
end
