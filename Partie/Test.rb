require './Grille'
require './CaseNombre'
require './Case'
require './CaseJouable'
require './Partie'
class Test
	def Test.test()
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

		partie.clicSurCase(2,1)
		partie.clicSurCase(1,1)
		partie.clicSurCase(0,2)
		partie.clicSurCase(2,0)

		puts partie.grilleEnCours
		puts "Partie finie ? = #{partie.partieFinie?}"
		puts partie.grilleEnCours.nbErreurs

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
		partie.clicSurCase(2,0)
		puts partie.grilleEnCours

		ile1NonEntouree = partie.indice_ile1NonEntouree
		if(ile1NonEntouree!=nil) 
			puts "Ile 1 non entouree aux coordonnées x = #{ile1NonEntouree[0]} y = #{ile1NonEntouree[1]}"
		end


	end

	Test.test()
end
