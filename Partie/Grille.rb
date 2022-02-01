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
		for i in 0..@taille-1  do
			for j in 0..@taille-1 do
				if(mat2[j][i].is_a?(CaseJouable))
					c = CaseJouable.creer()
					c.changerEtat(mat2[j][i].etat)
					@matriceCases[j][i]=c
				else
					@matriceCases[j][i]=CaseNombre.creer(mat2[j][i].valeur)
				end
			end 
		end 
	end
	
	def to_s()
		for i in 0..@taille-1  do
			for j in 0..@taille-1 do
				print @matriceCases[j][i].to_s
				print " "
			end 
			print "\n"
		end 
	end

	def pourcentageCompletion(grilleCmp)
		nbPareil = 0
		for i in 0..@taille - 1
			for j in 0..@taille - 1
				if(@matriceCases[i][j].is_a?(CaseJouable) && @matriceCases[i][j].etat==grilleCmp.matriceCases[i][j].etat)
					nbPareil += 1
				end
			end
		end
		return (nbPareil/(@taille*@taille).to_f)*100
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


		
