class CaseJouable
	@etat

	def CaseJouable.creer()
		new()
	end

	private_class_method :new
	attr :etat, true

	def initialize()
		@etat=0
	end

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
