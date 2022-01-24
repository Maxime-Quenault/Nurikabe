require './Case'
class CaseNombre < Case

	@valeur

	def CaseNombre.creer(val)
		new(val)
	end
	private_class_method :new
	def initialize(val)
		@valeur=val
	end

	def <=>(c)
		return @valeur<=>c.valeur
	end

	attr :valeur, false

end
