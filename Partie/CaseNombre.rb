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
		print @valeur
	end

	attr :valeur, false

end
