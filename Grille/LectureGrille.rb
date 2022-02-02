class LectureGrille

    # Constantes de difficulté
    FACILE = 0
    NORMAL = 1
    DIFFICILE = 2

    def lireGrille(unIndex, uneDifficulte)
        compteur = 0
        chaine = ""

        if (uneDifficulte == FACILE)
            File.foreach('./Fichiers/grillesEasy.txt') do |line|

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

		x = 0, y = 0, compteur = 0
		grille.each_with_index do |line, index|
			x = 0
			for j in grille[index].split do
				if (j == "2" || j == 2)
					matriceCases[y][x] = numeroCases[compteur].to_i
					compteur += 1
				else
					matriceCases[y][x] = j.to_i
				end
				
				x += 1
			end
			y += 1
		end

		p matriceCases

    end

    # faire def toGrilleSolution

end

p = LectureGrille.new()
p.toGrilleJouable(1, 0)

