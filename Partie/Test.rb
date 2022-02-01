require './Grille'
require './CaseNombre'
require './Case'
require './CaseJouable'
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
		
		g = Grille.creer(1,3)
		mat=Array.new(3){Array.new(3)}
		mat[0][0]=c1
		mat[0][1]=c2
		mat[0][2]=cn1
		mat[1][0]=c4
		mat[1][1]=c5
		mat[1][2]=cn2
		mat[2][0]=c3
		mat[2][1]=c6
		mat[2][2]=cn3
		g.copierMatrice(mat)
		

	end
end