require './CaseNombre'
require './Case'
require './CaseJouable'
class Grille
	@numero
	@taille
	@matriceCases

	def Grille.creer(num,t)
		new(num,t)
	end

	private_class_method :new
	attr :matriceCases, false
	attr :taille, false
	attr :numero, false
	def initialize(num,t)
		@numero=num
		@taille=t
		@matriceCases=Array.new(@taille){Array.new(@taille)}
	end

	def copierMatrice(mat2)
		@matriceCases=mat2
	end
	
	def pourcentageCompletion(grilleCmp)
		nbPareil = 0
		for i in 0..@taille - 1
			for j in 0..@taille - 1
				if(@matriceCases[i][j]==grilleCmp.matriceCases[i][j]&&@matriceCases[i][j].is_a?(CaseJouable))
					nbPareil += 1
				end
			end
		end
		return nbPareil/(@taille*@taille)
	end

	def nbErreurs(grilleCmp)
		nbErr = 0
		for i in 0..@taille - 1
			for j in 0..@taille - 1
				if(@matriceCases[i][j]!=grilleCmp.matriceCases[i][j]&&@matriceCases[i][j].is_a?(CaseJouable)&&@matriceCases[i][j].etat!=0)
					nbErr += 1
				end
			end
		end
		return nbErr
	end
	

	def raz()
		for i in 0..@taille - 1
			for j in 0..@taille - 1
				if(@matriceCases[i][j].is_a?(CaseJouable))
					@matriceCases[i][j].changerEtat(0)
				end
			end
		end
	end
	
	def affichage()
		print @matriceCases
	end

end


		
