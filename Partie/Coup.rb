require './Case'

class Coup
	@case
	@ancienEtat

	def Coup.creer(c, ancienEtat)
		new(c,ancienEtat)
	end

	private_class_method :new
	attr :case, false
	attr :ancienEtat, false
	def initialize(c, ancienEtat)
		@case=c
		@ancienEtat=ancienEtat
	end
end
