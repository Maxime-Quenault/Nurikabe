# Représentes une case sur laquelle on peut cliquer
class CaseJouable
	# l'état indique si la case est une case île, océan ou non jouée
	# 0 = case non jouée
	# 1 = océan
	# 2 = ile
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
			return "."
		elsif @etat==1 then
			return "x"
		else
			return "o"
		end
	end

	def <=>(c)
		return @etat<=>c.etat
	end
end
