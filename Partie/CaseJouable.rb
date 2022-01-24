require './Case'

class CaseJouable < Case
	@etat

	def CaseJouable.creer(couleur,x,y)
		new(couleur,x,y)
	end

	private_class_method :new
	attr :etat, true

	def initialize(couleur,x,y){
		super(x,y)
		@etat=0
	end

	def changerEtat(e)
		@etat=e
	end
	
end

