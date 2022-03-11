# Classes à charger :
# Sûrement d'autres à ajouter
load "../Partie/Grille.rb"

# Définition de la classe Aventure
class Aventure

  #############################################################################################################################
  # Explications sur la manière de concevoir cette classe ,                                                                   #
  # En se basant sur le modèle de l'interface du mode Aventure,                                                               #
  # => L'interface possède 3 niveaux de difficultée (Facile,Normal,Difficile)                                                 #
  # => Le joueur peut changer de difficulté                                                                                   #
  # => Le joueur possède un compteur d'étoile, qu'il augmente si il termine des grilles                                       #
  #                                                                                                                           #
  # En partant de cela on peut supposer/déduire qu'il y aurait 3 objets de classe Aventure,                                   #
  # => un objet par difficulté, dont une VI qui aurait une valeur différente                                                  #
  # => les structures sont les mêmes et les objets ont les mêmes comportements,                                               #
  # seules les valeurs changent (le parcours (l'ensemble des grilles formant l'aventure), la position de la grille courante   #
  # dans l'aventure, la prochaine difficulté, la difficulté précédente)                                                       #
  # => faire 3 objets Aventures permet de ne pas dupliquer de code et de ne pas stocker les 3 trois parcours aventure         #
  # dans le même objet, de même si l'on souhaite ajouter une difficulté supplémentaire il suffira de créer un nouvel objet    #
  #                                                                                                                           #
  # Ainsi pour faire la liaison entre les différentes aventures, on place en tant que variable de classe:                     #
  # => le nombre d'étoile du joueur (reste le même lorsqu'il changent de difficulté d'aventure)                               #
  # => les coûts des "paliers" (le nombre d'étoile nécessaire pour les difficultés reste le même)                             #
  # => les accès aux difficultés déjà débloquées (si un joueur débloque la difficulté Normale et qu'il commence cette         #
  # aventure, la difficulté Facile sera considérée comme étant toujours débloquée)                                            #
  #############################################################################################################################

  # entier qui représente le score du joueur en nombre d'étoiles
  @@nbEtoiles
  # entier qui définit le nombre d'étoiles nécessaires pour débloquer la difficultée normale
  @@palierNormal
  # entier qui définit le nombre d'étoiles nécessaires pour débloquer la difficultée hard
  @@palierHard
  # tableau de 3 booléens indiquant pour chaque difficultée, si elles sont débloquée ou non
  @@difficuleAcquise
  # tableau contenant les grilles du mode aventure
  @desGrilles
  # tableau contenant le nombre d'étoiles de chaque grille
  @desEtoiles
  # position courante dans le mode Aventure
  @posCourante
  # entier représentant la difficultée actuelle associée à cette Aventure
  # 0 -> Facile   1 -> Normal   2 -> Hard
  @difficulte
  # Aventure précédente (dans l'ordre chronologique)
  # Par exemple : pour l'aventure "Normale" precedente sera "Facile"
  @precedenteDiff
  # Même cas pour l'aventure suivante
  @suivanteDiff


  # Coding Assistant pour faciliter les accès des différentes variables
  attr_reader :palierNormal, :palierHard, :desGrilles, :difficuleAcquise, :difficulte, :precedenteDiff, :suivanteDiff;
  attr :posCourante, :nbEtoiles, :desEtoiles true;

  # On définit notre propre façon de générer une Aventure
  def Aventure.creer(aventurePreced, uneDifficulte, aventureSuiv)
    new(aventurePreced, uneDifficulte, aventureSuiv)
  end

  # on redéfinit la méthode initialize() pour générer l'Aventure selon nos critères
  def initialize(uneDifficulte)
    # Consernant les valeurs des deux VI palier ci-dessous elles sont provisoires(test) -> se mettre d'accord plus tard
    @@palierNormal = 30
    @@palierHard = 70
    @@nbEtoiles = 0
    @desGrilles = Array.new()
    #Tableau qui contiendra les étoiles de chaque grille
    @desEtoiles = Array.new()

    @posCourante = 0
    @difficulte = uneDifficulte
    # Ici on initialise le tableau de sorte que seule la première difficulté(Facile) soit débloquée
    @@difficulteAcquise = Array.new()
    @@difficulteAcquise[0] = true
    @@difficulteAcquise[1] = @@difficulteAcquise[2] = false
  end

  # Lien entre les différentes aventures
  # Méthode d'accès en ecriture qui édite le lien de cette aventure avec la précédente(si il y en a)
  def setPrecedent(aventurePreced)
    @precedenteDiff = aventurePreced
  end

  # Méthode d'accès en ecriture qui édite le lien de cette aventure avec la suivante(si il y en a)
  def setSuivant(aventureSuiv)
    @suivanteDiff = aventureSuiv
  end

  # Pour générer l'aventure(suite de niveaux), on fait appel à la classe Grille pour générer les niveaux
  def generationAventure(nbNiveau)
    for(int i; i < nbNiveau; i++)
      @desGrilles[i] = Grille.new()
      @desEtoiles[i] = 0
    end
  end

  # On se déplace sur le plateau du mode Aventure : ici on recule et on retourne au niveau précédent
  def grillePrecedente
    if(@posCourante > 0)
      @posCourante -= 1
    end
  end

  # On se déplace sur le plateau du mode Aventure : ici on avance et on va au niveau suivant
  def prochaineGrille
    if(@posCourante < @desGrilles.length())
      @posCourante += 1
    end
  end

  # On se déplace sur le plateau du mode Aventure : ici on se place sur un niveau précis
  def placerSurGrille(numero)
    if((@posCourante > 0) && (@posCourante < @desGrilles.length()))
      @posCourante = numero
    end
  end

  # Méthode d'accès en lecture de la position courante
  def getEtoileCourante
    return @desEtoiles[@posCourante]
  end

  # Méthode d'accès en écriture du nombre d'étoiles de la grille
  def setEtoileCourante(unNombre)
    if(unNombre > self.getEtoileCourante())
      etoilesEnPlus(unNombre - self.getEtoileCourante())
      @desEtoiles[@posCourante] = unNombre
    end
  end

  # Méthode d'accès en lecture de la position courante sur le plateau
  def getPosCourante
    return @posCourante
  end

  # Méthode d'accès en lecture de la grille courante
  def getGrilleCourante
    return @desGrilles[@posCourante];
  end

  # On se déplace sur l'aventure de difficulté inférieure
  def difficultePrecedente
    return @precedenteDiff
  end

  # On se déplace sur l'aventure de difficulté supérieure
  def difficulteSuivante
    return @suivanteDiff
  end

  # Le joueur a terminé sa grille et obtient des étoiles :
  # ces étoiles sont ajoutées à son compteur
  def etoilesEnPlus(desEtoiles)
    @@nbEtoiles += desEtoiles
  end

  # On veut savoir si le joueur a assez d'étoiles comparé à un certain montant :
  # Retourne true si le joueur en a assez, false sinon
  def assezEtoiles?(unNombre)
    return (@@nbEtoiles >= unNombre)
  end

  # Le joueur choisit une difficulte
  # 0 -> Facile
  # 1 -> Normal
  # 2 -> Hard
  def choixDifficulte(uneDiff)
    if((uneDiff >= 0) && (uneDiff < 3) && (@@difficulteAcquise[uneDiff] == true))
      if(uneDiff > @difficulte)
        @suivanteDiff.choixDifficulte(uneDiff)
      elsif(uneDiff < @difficulte)
          @precedenteDiff.choixDifficulte(uneDiff)
      end
    end
  end

  # Le joueur souhaite débloquer une difficulté :
  # On verifie d'abord qu'il ne l'a pas déjà débloquée et ensuite son nombre d'étoiles
  # On affiche un message selon si il possède ou non assez d'étoiles, et si c'est le cas on actualise le tableau des difficultés acquises
  def unlockDifficulte
    # Dans le cas où seule la difficulté Facile est débloquée
    if((@difficulte == 0) && (@@difficulteAcquise[1] == false))
      if(self.assezEtoiles?(@@palierNormal))
        @@difficulteAcquise[1] = true;
        print("\nBravo tu viens de débloquer la difficulté Normal !")
      else
        print("\nTu ne possèdes pas assez d'étoiles pour débloquer cette difficulté...\nRefais d'autres niveaux.")
      end
    elsif((@difficulte == 1) && (@@difficulteAcquise[2] == false))
      # Dans le cas où la difficulté Normal est débloquée
        if(self.assezEtoiles?(@@palierHard))
          @@difficulteAcquise[2] = true
          print("\nBravo tu viens de débloquer la difficulté Hard !")
        else
          print("\nTu ne possèdes pas assez d'étoiles pour débloquer cette difficulté...\nRefais d'autres niveaux.")
        end
    end
  end

end
