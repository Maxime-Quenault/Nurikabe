load "Partie/Case.rb"
# Représentes un coup effectué lors d'une partie
class Coup
	# contient la case sur laquelle le coup a été joué
	@case
	# l'ancien état de la case
	@ancienEtat
	#l'état courant de la case
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
