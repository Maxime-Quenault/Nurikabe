require './Case'
class CaseNombre < Case

	@valeur

	def CaseNombre.creer(val, x, y)
		new(val,x,y)
	end
	private_class_method :new
	def initialize(val,x,y)
		super(x,y)
		@valeur=val
	end
	
	def <=>(c)
		return @valeur<=>c.valeur 
	end
	
	attr :valeur, false
	
end

