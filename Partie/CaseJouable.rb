require './Case'

class CaseJouable < Case
	@etat

	def CaseJouable.creer()
		new()
	end

	private_class_method :new
	attr :etat, true

	def initialize()
		@etat=0
	end

	def changerEtat(e)
		@etat=e
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
