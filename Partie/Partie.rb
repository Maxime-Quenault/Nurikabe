require './Grille'
require './Coup'
# Représentes une partie, contient :
# une grille en cours, sur laquelle on va jouer
# un chronomètre
# un tableau de coups, sert pour les undo et redo
# un indice du coup auquel on est
# un booléen en pause
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

  # ajoutes le coup passé en paramètre au tableau de coups et incrémente l'indiceCoup
  def nouveauCoup(unCoup)
    @tabCoup.append(unCoup)
    @indiceCoup+=1
  end

  # changes l'état de la case cliquée et créer un nouveau coup correspondant
  def clicSurCase(x,y)
    if(@grilleEnCours.matriceCases[x][y].is_a?(CaseJouable))
	  	anc_etat =@grilleEnCours.matriceCases[x][y].etat
      @grilleEnCours.matriceCases[x][y].changerEtat
		  self.nouveauCoup(Coup.creer(@grilleEnCours.matriceCases[x][y],anc_etat,@grilleEnCours.matriceCases[x][y].etat))
      if(tabCoup[indiceCoup+1].is_a?(Coup))
        i=indiceCoup+1
        while(tabCoup[i].is_a?(Coup))
          tabCoup[i]==nil
          i+=1
        end
      end
    end
  end

  # vrai si on peut undo, faux sinon
  def undoPossible?()
    return @indiceCoup>0
  end

  # Retournes à l'état précédant le dernier clic sur une case
  def undo()
    if(self.undoPossible?)
      tmpEtat=@tabCoup[@indiceCoup-1].case.etat
      tmpCase=@tabCoup[@indiceCoup-1].case
      @tabCoup[@indiceCoup-1].case.etat=@tabCoup[@indiceCoup-1].ancienEtat
      @indiceCoup-=1
    end
  end

  # vrai si on peut redo, faux sinon
  def redoPossible?()
	   return @tabCoup[@indiceCoup+1].is_a?(Coup)
  end

  # Retournes à l'état suivant
  def redo()
    @tabCoup[indiceCoup].case.etat=@tabCoup[indiceCoup].etat
    @indiceCoup+=1
  end

  # Remet les variables d'instance à 0
  def raz()
    @grilleEnCours.raz()
    @tabCoup=Array.new()
    @indiceCoup=0
    @enPause=false
  end

  #vrai si la partie est finie faux sinon
  def partieFinie?()
    return @grilleEnCours.grilleFinie
  end

  #undo tant qu'il y a des erreurs
  def reviensALaBonnePosition()
    while(@grilleEnCours.nbErreurs>0)
      puts @grilleEnCours
      self.undo
    end
  end

  def metToiEnPause()
  end

  def reprend()
  end

end
