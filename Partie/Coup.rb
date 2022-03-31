load "Partie/Case.rb"

=begin
	@author Julian LEBOUC
	La classe Coup :::
		- représente un coup effectué lors d'une partie

	Les VI de la classe sont :::
		- @case 		==> contient la case sur laquelle le coup a été joué 
		- @ancienEtat	==> ancien état de la case 
		- @etat			==> état courant de la case

=end

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

	##
	#constructeur de Coup, prends en paramètres une case, son ancien état et son état actuel
	def initialize(c, ancienEtat, etat)
		@case=c
		@ancienEtat=ancienEtat
		@etat=etat
	end
end
