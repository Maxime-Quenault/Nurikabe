require './Grille'
require './Coup'

class Partie
  @grilleEnCours
  @chronometre
  @tabCoup
  @indiceCoup
  @enPause

  def Partie.creeToi(uneGrille)
    new(uneGrille)
  end
  private_class_method :new

  attr :grilleEnCours, false
  attr :chronometre, false
  attr :tabCoup, false
  attr :indiceCoup, false
  attr :enPause, false
  def initialize(uneGrille)
    @grilleEnCours=uneGrille
    @tabCoup=Array.new()
    @indiceCoup=0
    @enPause=false
    #@chronometre=Chronometre.creer()
  end

  def nouveauCoup(unCoup)
    @tabCoup.append(unCoup)
    @indiceCoup+=1
  end

  def clicSurCase(x,y)
		self.nouveauCoup(Coup.creer(@grilleEnCours.matriceCases[x][y],@grilleEnCours.matriceCases[x][y].etat))
		@grilleEnCours.matriceCases[x][y].changerEtat()
  end

  def undoPossible?()
    return @indiceCoup>0
  end

  def undo()
    if(self.undoPossible?)
      tmpEtat=@tabCoup[@indiceCoup-1].case.etat
      tmpCase=@tabCoup[@indiceCoup-1].case
      @tabCoup[@indiceCoup-1].case.etat=@tabCoup[@indiceCoup-1].ancienEtat
      @tabCoup[@indiceCoup]=Coup.creer(tmpCase,tmpEtat)
      @indiceCoup-=1
    end
  end

  def redoPossible?()
	   return @tabCoup[@indiceCoup+1]!=null
  end

  def redo()
    @tabCoup[indiceCoup+1].case.etat=@tabCoup[indiceCoup+1].ancienEtat
    @indiceCoup+=1
  end

  def raz()
    @grilleEnCours.raz()
    @tabCoup=Array.new()
    @indiceCoup=0
    @enPause=false
  end

  def partieFinie?()
    return @grilleEnCours.grilleFinie
  end


# Erreur ne reviens pas au bon moment
  def reviensALaBonnePosition()
    while(@grilleEnCours.nbErreurs>0)
      puts @grilleEnCours
      self.undo
    end
  end
end
