require './Case'

class CaseJouable < Case
	@etat

	def CaseJouable.creer(couleur)
		new(couleur)
	end

	private_class_method :new
	attr :etat, true

	def initialize(couleur){
		@etat=0
	end

	def changerEtat(e)
		@etat=e
	end

	def <=>(c)
		return @etat<=>c.etat
	end
end
