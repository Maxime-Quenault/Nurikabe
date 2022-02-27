require './Grille'
require './CaseNombre'
require './Case'
require './CaseJouable'
require './Partie'
require './Indice'
class Test
	def Test.test()
		# On créer des cases, les mets dans une matrice et on les copie dans une grille de taille 3*3
		c1 = CaseJouable.creer()
		c2 = CaseJouable.creer()
		c3 = CaseJouable.creer()
		c4 = CaseJouable.creer()
		c5 = CaseJouable.creer()
		c6 = CaseJouable.creer()
		cn1 = CaseNombre.creer(1)
		cn2 = CaseNombre.creer(1)
		cn3 = CaseNombre.creer(2)

		g = Grille.creer(1,3,3)
		mat=Array.new(3){Array.new(3)}
		mat[0][0]=c1
		mat[0][1]=cn1
		mat[0][2]=c2
		mat[1][0]=cn2
		mat[1][1]=c5
		mat[1][2]=c4
		mat[2][0]=c3
		mat[2][1]=c6
		mat[2][2]=cn3
		g.copierMatrice(mat)

		# On créer des cases, on change leur état, les mets dans une matrice et on les copie dans une grille de taille 3*3 en tant que matrice corrigée
		cc1 = CaseJouable.creer()
		cc2 = CaseJouable.creer()
		cc3 = CaseJouable.creer()
		cc4 = CaseJouable.creer()
		cc5 = CaseJouable.creer()
		cc6 = CaseJouable.creer()
		ccn1 = CaseNombre.creer(1)
		ccn2 = CaseNombre.creer(1)
		ccn3 = CaseNombre.creer(2)

		cc1.changerEtat
		cc2.changerEtat
		cc3.changerEtat
		cc4.changerEtat
		cc5.changerEtat
		cc6.changerEtat.changerEtat

		matcor=Array.new(3){Array.new(3)}
		matcor[0][0]=cc1
		matcor[0][1]=ccn1
		matcor[0][2]=cc2
		matcor[1][0]=ccn2
		matcor[1][1]=cc5
		matcor[1][2]=cc4
		matcor[2][0]=cc3
		matcor[2][1]=cc6
		matcor[2][2]=ccn3
		g.copierCorrection(matcor)

		puts "Grille De début :"
		puts g
		g.matriceCases[0][0].changerEtat()
		g.matriceCases[2][1].changerEtat()
		puts "On joue un bon et un mauvais coup :"
		puts g
		puts "Taux de completion #{g.pourcentageCompletion()}"

		puts "#{g.nbErreurs()} erreurs"

		partie = Partie.creeToi(g)
		partie.clicSurCase(1,2)
		puts "On joue un coup :"
		puts partie.grilleEnCours
		partie.undo
		puts "Undo"
		puts partie.grilleEnCours
		puts "Redo"
		partie.redo
		puts partie.grilleEnCours

		puts partie.clicSurIndice

		puts "On joue des coups pour finir la grille"
		partie.clicSurCase(2,1)
		partie.clicSurCase(1,1)
		partie.clicSurCase(0,2)
		partie.clicSurCase(2,0)

		puts partie.grilleEnCours
		puts "Partie finie ? = #{partie.partieFinie?}"
		puts " Nb erreurs : #{partie.grilleEnCours.nbErreurs}"

		puts "On fait des erreurs"
		partie.clicSurCase(2,0)
		puts partie.grilleEnCours
		partie.clicSurCase(2,1)
		puts partie.grilleEnCours
		partie.clicSurCase(1,1)
		puts partie.grilleEnCours


		puts " On reviens ou il n'y avait pas derreur "
		partie.reviensALaBonnePosition
<<<<<<< HEAD
		
=======
		puts partie.grilleEnCours

		puts " On met une case à l'état non jouée à coté d'une case 1"
		partie.clicSurCase(2,0)
		puts partie.grilleEnCours
		partie.clicSurCase(2,0)
		puts partie.grilleEnCours

		puts partie.clicSurIndice
		
		puts " On undo, clic sur une case puis on test si on peux redo"
		partie.undo
		puts " Avant de cliquer sur une case :"
>>>>>>> Julian
		puts partie.grilleEnCours
		puts "Redo possible ? #{partie.redoPossible?}"
		partie.clicSurCase(1,1)
		puts " Après avoir cliqué sur une case :"
		puts partie.grilleEnCours
		puts "Redo possible ? #{partie.redoPossible?}"

	end

	Test.test()
end
