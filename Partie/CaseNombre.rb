=begin
	
	La classe CaseNombre :::
		- représente une case contenant un nombre 

	La VI de cette classe est :::
		- @valeur	==> valeur entière présente dans la case

=end

class CaseNombre
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

	def to_s
		return @valeur.to_s
	end

	attr :valeur, false

end
