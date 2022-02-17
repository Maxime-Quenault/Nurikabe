class Libre


    def toGrilleJouable(unIndex, uneDifficulte)

        chaine = lireGrille(unIndex, uneDifficulte)

        numeroCases = chaine.lines.first.split(' ')
        grille = chaine.lines.drop(1)

        #Création de la matrice de cases
        matriceCases = Array.new(grille.length) {Array.new(grille[0].split.lenght)}

        y = 0 
        compteur = 0

        grille.each_with_index do |line, index|
            x = 0
            for j in grille[index].split do
                if( j=="0" || j == 0 )
                    matriceCases[y][x] = grille[index][line] + 1 
                else
                    matriceCases[y][x] = j.to_i
                    
                end

                x += 1
            end
            y += 1
        end

    end

end
