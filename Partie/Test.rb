require './Grille'
require './CaseNombre'
require './Case'
require './CaseJouable'
require './Partie'
require './Indice'
class Test
	def Test.test()
=begin
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
		puts partie.grilleEnCours
		puts "Redo possible ? #{partie.redoPossible?}"
		partie.clicSurCase(1,1)
		puts " Après avoir cliqué sur une case :"
		puts partie.grilleEnCours
		puts "Redo possible ? #{partie.redoPossible?}"
=end
		puts "On créer une grille et charge les matrices depuis le fichier txt"
		g2=Grille.creer(2,8,6)
		g2.toGrilleJouable(g2.numero,0)
		partie = Partie.creeToi(g2)
		puts partie.grilleEnCours

		puts "On demande un indice"
		puts partie.clicSurIndice

		puts "On résoud l'indice"
		partie.clicSurCase(3,1)
		partie.clicSurCase(2,2)
		partie.clicSurCase(4,2)
		partie.clicSurCase(3,3)
		puts partie.grilleEnCours

		puts "Pourcentage Completion: #{partie.grilleEnCours.pourcentageCompletion}"

		puts "On demande un indice"
		puts partie.clicSurIndice

		puts "On résoud l'indice"
		partie.clicSurCase(1,7)
		puts partie.grilleEnCours

		puts "On demande un indice"
		puts partie.clicSurIndice

		puts "On résoud l'indice"
		partie.clicSurCase(1,3)
		puts partie.grilleEnCours

		puts "On demande un indice"
		puts partie.clicSurIndice

		puts "On créer volontairement un carré d'océan de taille 2*2"
		partie.clicSurCase(3,4)
		partie.clicSurCase(4,4)
		partie.clicSurCase(3,5)
		partie.clicSurCase(4,5)
		puts partie.grilleEnCours

		puts "On demande un indice"
		puts partie.clicSurIndice

		puts "On résoud l'indice "
		partie.clicSurCase(3,4)
		puts partie.grilleEnCours



		puts "Nb erreurs (fonction nbErreurs) : #{partie.grilleEnCours.nbErreurs}"
		puts "On fait volontairement une erreur"
		partie.clicSurCase(5,0)
		puts partie.grilleEnCours
		puts "On fait volontairement une autre erreur"
		partie.clicSurCase(3,0)
		puts partie.grilleEnCours

		puts "Nb erreurs (fonction nbErreurs) : #{partie.grilleEnCours.nbErreurs}"

		puts "On undo"
		partie.undo
		puts partie.grilleEnCours

		puts "On undo encore"
		partie.undo
		puts partie.grilleEnCours

		puts "On redo"
		partie.redo
		puts partie.grilleEnCours

		puts "On redo encore"
		partie.redo
		puts partie.grilleEnCours

		puts " On reviens ou il n'y avait pas derreur avec la fonction reviensALaBonnePosition"
		partie.reviensALaBonnePosition 
		puts partie.grilleEnCours


		puts " On undo, clic sur une case puis on test si on peux redo"
		partie.undo
		puts " Avant de cliquer sur une case :"
		puts partie.grilleEnCours
		puts "Redo possible ? #{partie.redoPossible?}"
		partie.clicSurCase(1,1)
		puts " Après avoir cliqué sur une case :"
		puts partie.grilleEnCours
		puts "Redo possible ? #{partie.redoPossible?}"
		puts " On tente quand même de redo"
		partie.redo
		puts partie.grilleEnCours
		puts " Rien ne se passe, c'est bon"

		puts "On joue maintenant tout les coups pour finir la partie"
		partie.clicSurCase(0,0)
		partie.clicSurCase(1,0)
		partie.clicSurCase(2,0)
		partie.clicSurCase(3,0)
		partie.clicSurCase(3,0)
		partie.clicSurCase(5,0)
		partie.clicSurCase(5,0)
		partie.clicSurCase(0,1)
		partie.clicSurCase(1,1)
		partie.clicSurCase(2,1)
		partie.clicSurCase(4,1)
		partie.clicSurCase(5,1)
		partie.clicSurCase(5,1)
		partie.clicSurCase(0,2)
		partie.clicSurCase(5,2)
		partie.clicSurCase(5,2)
		partie.clicSurCase(0,3)
		partie.clicSurCase(4,3)
		partie.clicSurCase(5,3)
		partie.clicSurCase(5,3)
		partie.clicSurCase(0,4)
		partie.clicSurCase(1,4)
		partie.clicSurCase(1,4)
		partie.clicSurCase(2,4)
		partie.clicSurCase(2,4)
		partie.clicSurCase(3,4)
		partie.clicSurCase(5,4)
		partie.clicSurCase(5,4)
		partie.clicSurCase(0,5)
		partie.clicSurCase(0,5)
		partie.clicSurCase(1,5)
		partie.clicSurCase(2,5)
		partie.clicSurCase(5,5)
		partie.clicSurCase(0,6)
		partie.clicSurCase(0,6)
		partie.clicSurCase(1,6)
		partie.clicSurCase(2,6)
		partie.clicSurCase(2,6)
		partie.clicSurCase(3,6)
		partie.clicSurCase(4,6)
		partie.clicSurCase(4,6)
		partie.clicSurCase(3,7)
		partie.clicSurCase(4,7)
		partie.clicSurCase(4,7)
		partie.clicSurCase(5,7)
		partie.clicSurCase(5,7)
		puts partie.grilleEnCours
		puts "Nb erreurs (fonction nbErreurs) : #{partie.grilleEnCours.nbErreurs}"
		puts "Partie finie ?(fonction partieFinie?) = #{partie.partieFinie?}"

		puts "On clic sur une case pour la rendre isolée (entourée d'océan ou des bords de la grille) et on lui donne l'état non joué"
		partie.clicSurCase(0,3)
		partie.clicSurCase(0,3)
		puts partie.grilleEnCours

		puts "On demande un indice"
		puts partie.clicSurIndice

		puts "On résoud l'indice"
		partie.clicSurCase(0,3)
		puts partie.grilleEnCours

		puts "On clic 2 fois sur la case à x=1 y=6"
		partie.clicSurCase(1,6)
		partie.clicSurCase(1,6)
		puts partie.grilleEnCours

		puts "On demande un indice"
		puts partie.clicSurIndice


	end

	Test.test()
end
