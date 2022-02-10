require './Case'

class Coup
	@case
	@ancienEtat
	@etat

	def Coup.creer(c, ancienEtat, etat)
		new(c,ancienEtat,etat)
	end

	private_class_method :new
	attr :case, false
	attr :ancienEtat, false
	attr :etat, false

	def initialize(c, ancienEtat, etat)
		@case=c
		@ancienEtat=ancienEtat
		@etat=etat
	end
end
