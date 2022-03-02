load "Partie/CaseNombre.rb"
load "Partie/Case.rb"
load "Partie/CaseJouable.rb"
class Grille
	#Représntes une grille, contient : 
	#un numéro (identifiant de la grille)
	#une hauteur et une largeur
	#une matrice de cases sur laquelle on jouera
	#une matrice de cases corrigée
	#un nombre d'étoiles
	@numero
	@hauteur
	@largeur
	@matriceCases
	@correction
	@etoiles

	FACILE = 0
	
	def Grille.creer(num,h,l)
		new(num,h,l)
	end

	private_class_method :new
	attr :matriceCases, false
	attr :numero, false
	attr :correction, false
	attr :etoiles, true
	attr :hauteur, false
	attr :largeur, false

	def initialize(num,h,l)
		@numero=num
		@hauteur=h
		@largeur=l
		@matriceCases=Array.new(@largeur){Array.new(@hauteur)}
		@correction=Array.new(@largeur){Array.new(@hauteur)}
		@etoiles=0
	end

	#affectes les cases de la matrice passée en paramètre à la matriceCases
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

	#affectes les cases de la matrice passée en paramètre à la matrice correction
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
		res = "-------------\n"
		for i in 0..@hauteur-1  do
			for j in 0..@largeur-1 do
				res+= @matriceCases[j][i].to_s
				res+= " "
			end
			res+= "\n"
		end
		return res
	end

	# retournes le pourcentage de complétion de la matriceCases
	def pourcentageCompletion()
		nbPareil = 0
		nbCasesNombre = 0
		for j in 0..@hauteur - 1
			for i in 0..@largeur - 1
				if(@matriceCases[i][j].is_a?(CaseJouable) && @matriceCases[i][j].etat==@correction[i][j].etat)
					nbPareil += 1
				elsif (@matriceCases[i][j].is_a?(CaseNombre))
					nbCasesNombre+=1
				end
			end
		end
		return (nbPareil/(@hauteur*@largeur-nbCasesNombre).to_f)*100
	end

	# retournes le nombre d'erreurs de la matriceCases
	def nbErreurs()
		nbErr = 0
		for j in 0..@hauteur - 1
			for i in 0..@largeur - 1
				if(@matriceCases[i][j].is_a?(CaseJouable)&&@matriceCases[i][j].etat!=@correction[i][j].etat&&@matriceCases[i][j].etat!=0)
					nbErr += 1
				end
			end
		end
		return nbErr
	end

	# retournes un booléen : vrai si la matriceCases est finie, faux sinon
	def grilleFinie()
		nbErr = 0
		for j in 0..@hauteur - 1
			for i in 0..@largeur - 1
				if(@matriceCases[i][j].is_a?(CaseJouable)&&@matriceCases[i][j].etat!=@correction[i][j].etat)
					nbErr += 1
				end
			end
		end
		return nbErr==0
	end

	# Remet toutes les cases jouables de la matriceCases à l'état non joué
	def raz()
		for j in 0..@hauteur - 1
			for i in 0..@largeur - 1
				if(@matriceCases[i][j].is_a?(CaseJouable))
					@matriceCases[i][j].etat=0
				end
			end
		end
	end

	def lireGrille(unIndex, uneDifficulte)
        compteur = 0
        chaine = ""

        if (uneDifficulte == FACILE)
            File.foreach('./grillesEasy.txt') do |line|

                if line.eql?("\n")
                    compteur += 1
				elsif compteur == unIndex
                    chaine << line
                end

                return chaine if (compteur == unIndex + 1)

            end
        end

    end

    def toGrilleJouable(unIndex, uneDifficulte)

        chaine = lireGrille(unIndex, uneDifficulte)
        
        numeroCases = chaine.lines.first.split(' ')
        grille = chaine.lines.drop(1)

		# p grille[0].split <-- print chaque caractère de la ligne à part

		# Génération de la matrice de cases
		matriceCases = Array.new(grille.length) { Array.new(grille[0].split.length) }
		correction = Array.new(grille.length) { Array.new(grille[0].split.length) }

		x = 0, y = 0, compteur = 0
		grille.each_with_index do |line, index|
			x = 0
			for j in grille[index].split do
				if (j == "2" || j == 2)
					correction[x][y] = CaseNombre.creer(numeroCases[compteur].to_i) 
					matriceCases[x][y] = CaseNombre.creer(numeroCases[compteur].to_i) 
					compteur += 1
				else
					correction[x][y] = CaseJouable.creer()
					matriceCases[x][y] = CaseJouable.creer()
					if j.to_i == 0
						correction[x][y].etat=1
					else
						correction[x][y].etat=2
					end
				end
				
				x += 1
			end
			y += 1
		end

		self.copierMatrice(matriceCases)
		self.copierCorrection(correction)

    end

end
