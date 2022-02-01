require './Grille'
require './Coup'

class Partie
  @grilleEnCours
  @grilleBase
  @chronometre
  @tabCoup
  @indiceCoup
  @enPause

  def Partie.creeToi(uneGrille)
    initialize(uneGrille)
  end
  private_class_method :new
  def initialize(uneGrille)
    @grilleBase=uneGrille
    @grilleEnCours=uneGrille
    @tabCoup=Array.new()
    @indiceCoup=0
    @enPause=false
    @chronometre=Chronometre.creer()
  end

  def undoPossible?()
    return @indiceCoup>0
  end
  def undo()
    tmpEtat=@tabCoup[@indiceCoup-1].case.etat
    tmpCase=@tabCoup[@indiceCoup-1].case
    @tabCoup[@indiceCoup-1].case.changerEtat(@tabCoup[@indiceCoup-1].ancienEtat)
    @tabCoup[@indiceCoup]=Coup.creer(tmpCase,tmpEtat)
    @indiceCoup-=1
  end

  def redoPossible
	return @tabCoup[@indiceCoup+1]!=null
  end
  
  def redo()
   
  end
end
