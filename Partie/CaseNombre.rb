=begin
	@author Julian LEBOUC
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
	##
	#constructeur de CaseNombre, prends en paramêtre un entier et l'affectes à @valeur
	def initialize(val)
		@valeur=val
	end

	##
	#permet de comparer des CaseNombres selon leur valeur
	def <=>(c)
		return @valeur<=>c.valeur
	end

	def to_s
		return @valeur.to_s
	end

	attr :valeur, false

end
