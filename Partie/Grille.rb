require './CaseNombre'
require './Case'
require './CaseJouable'
class Grille
	@numero
	@hauteur
	@largeur
	@matriceCases
	@correction
	@etoiles

	def Grille.creer(num,h,l)
		new(num,h,l)
	end

	private_class_method :new
	attr :matriceCases, false
	attr :taille, false
	attr :numero, false
	attr :correction, false
	attr :etoiles, true

	def initialize(num,h,l)
		@numero=num
		@hauteur=h
		@largeur=l
		@matriceCases=Array.new(@largeur){Array.new(@hauteur)}
		@correction=Array.new(@largeur){Array.new(@hauteur)}
		@etoiles=0
	end

	def copierMatrice(mat2)
		for i in 0..@hauteur-1  do
			for j in 0..@largeur-1 do
				if(mat2[j][i].is_a?(CaseJouable))
					c = CaseJouable.creer()
					c.etat=mat2[j][i].etat
					@matriceCases[j][i]=c
				else
					@matriceCases[j][i]=CaseNombre.creer(mat2[j][i].valeur)
				end
			end
		end
	end

	def copierCorrection(mat2)
		for i in 0..@hauteur-1  do
			for j in 0..@largeur-1 do
				if(mat2[j][i].is_a?(CaseJouable))
					c = CaseJouable.creer()
					c.etat=mat2[j][i].etat
					@correction[j][i]=c
				else
					@correction[j][i]=CaseNombre.creer(mat2[j][i].valeur)
				end
			end
		end
	end


	def to_s()
		for i in 0..@hauteur-1  do
			for j in 0..@largeur-1 do
				print @matriceCases[j][i].to_s
				print " "
			end
			print "\n"
		end
	end


	def pourcentageCompletion()
		nbPareil = 0
		nbCasesNombre = 0
		for i in 0..@hauteur - 1
			for j in 0..@largeur - 1
				if(@matriceCases[i][j].is_a?(CaseJouable) && @matriceCases[i][j].etat==@correction[i][j].etat)
					nbPareil += 1
				elsif (@matriceCases[i][j].is_a?(CaseNombre))
					nbCasesNombre+=1
				end
			end
		end
		return (nbPareil/(@hauteur*@largeur-nbCasesNombre).to_f)*100
	end

	def nbErreurs()
		nbErr = 0
		for i in 0..@hauteur - 1
			for j in 0..@largeur - 1
				if(@matriceCases[i][j].is_a?(CaseJouable)&&@matriceCases[i][j].etat!=@correction[i][j].etat&&@matriceCases[i][j].etat!=0)
					nbErr += 1
				end
			end
		end
		return nbErr
	end

	def grilleFinie()
		nbErr = 0
		for i in 0..@hauteur - 1
			for j in 0..@largeur - 1
				if(@matriceCases[i][j].is_a?(CaseJouable)&&@matriceCases[i][j].etat!=@correction[i][j].etat)
					nbErr += 1
				end
			end
		end
		return nbErr==0
	end

	def raz()
		for i in 0..@hauteur - 1
			for j in 0..@largeur - 1
				if(@matriceCases[i][j].is_a?(CaseJouable))
					@matriceCases[i][j].etat=0
				end
			end
		end
	end

	def affichage()
		print @matriceCases
	end

end
