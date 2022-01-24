# Classes à charger :
load "Grille.rb";

class Aventure{

  # entier qui représente le score du joueur en nombre d'étoiles
  @@nbEtoiles
  # entier qui définit le nombre d'étoiles nécessaires pour débloquer la difficultée normale
  @@palierNormal
  # entier qui définit le nombre d'étoiles nécessaires pour débloquer la difficultée hard
  @@palierHard
  # tableau contenant les grilles du mode aventure
  @desGrilles
  # position courante dans le mode Aventure
  @posCourante
  # entier représentant la difficultée actuelle associée à cette Aventure
  # 0 -> Facile   1 -> Normal   2 -> Hard
  @difficulte
  # tableau de 3 booléens indiquant pour chaque difficultée, si elles sont débloquée ou non
  @@difficuleAcquise
  # Aventure précédente (dans l'ordre chronologique)
  # Par exemple :: pour l'aventure "Normale" precedente sera "Facile"
  @precedente
  # Même cas pour l'aventure suivante
  @suivante

  # Coding Assistant pour faciliter les accès des différentes variables
  attr_reader :nbEtoiles, :palierNormal, :palierHard, :desGrilles;
  attr :posCourante, :difficuleAcquise, :difficulte, true;

  # On définit notre propre façon de générer une Aventure
  def Aventure.creer(nbEtoileNorm, nbEtoileHard, aventurePreced, uneDifficulte, aventureSuiv){
    new(nbEtoileNorm, nbEtoileHard, aventurePreced, uneDifficulte, aventureSuiv);
  }

  # on redéfinit la méthode initialize() pour générer l'Aventure selon nos critères
  def initialize(nbEtoileNorm, nbEtoileHard, aventurePreced, uneDifficulte, aventureSuiv){
    @@palierNormal = nbEtoileNorm;
    @@palierHard = nbEtoileHard;
    @@nbEtoiles = 0;
    @desGrilles = Array.new();
    @posCourante = 0;
    @difficulte = uneDifficulte;
    # Ici on initialise le tableau de sorte que seule la première difficulté(Facile) soit débloquée
    @@difficuleAcquise = Array.new();
    @@difficuleAcquise[0] = true;
    @@difficuleAcquise[1] = @@difficuleAcquise[2] = false;
    # Lien entre les différentes aventures
    @precedente = aventurePreced;
    @suivante = aventureSuiv;
  }

  # Pour générer l'aventure(suite de niveaux), on fait appel à la classe Grille pour générer les niveaux
  def generationAventure(nbNiveau){
    for(int i; i < nbNiveau; i++){
      @desGrilles[i] = Grille.new();
    }
  }

  # On se déplace sur le plateau du mode Aventure : ici on recule et on retourne au niveau précédent
  def grillePrecedente(){
    if(@posCourante > 0){
      @posCourante -= 1;
    }
  }

  # On se déplace sur le plateau du mode Aventure : ici on avance et on va au niveau suivant
  def prochaineGrille(){
    if(@posCourante < @desGrilles.length()){
      @posCourante += 1;
    }
  }

  # On se déplace sur le plateau du mode Aventure : ici on se place sur un niveau précis
  def placerSurGrille(numero){
    if(@posCourante > 0 && @posCourante < @desGrilles.length()){
      @posCourante = numero;
    }
  }

  # Le joueur a terminé sa grille et obtient des étoiles :
  # ces étoiles sont ajoutées à son compteur
  def etoilesEnPlus(desEtoiles){
    @@nbEtoiles += desEtoiles;
  }

  # On veut savoir si le joueur a assez d'étoiles comparé à un certain montant :
  # Retourne true si le joueur en a assez, false sinon
  def assezEtoiles?(unNombre){
    return (@@nbEtoiles >= unNombre);
  }

  # Le joueur choisit une difficulte
  # 0 -> Facile
  # 1 -> Normal
  # 2 -> Hard
  def choixDifficulte(uneDiff){
    if(uneDiff >= 0 && uneDiff < 3 && @@difficuleAcquise[uneDiff] == true){
      @difficulte = uneDiff;
    }
  }

  # Le joueur souhaite débloquer une difficulté :
  # On verifie d'abord qu'il ne l'a pas déjà débloquée et ensuite son nombre d'étoiles
  # On affiche un message selon si il possède ou non assez d'étoiles, et si c'est le cas on actualise le tableau des difficultés acquises
  def unlockDifficulte(){
    # Dans le cas où seule la difficulté Facile est débloquée
    if(@difficulte == 0 && @@difficuleAcquise[1] == false){
      if(self.assezEtoiles?(1)){
        @@difficuleAcquise[1] = true;
        print("\nBravo tu viens de débloquer la difficulté Normal !");
      }else{
        print("\nTu ne possèdes pas assez d'étoiles pour débloquer cette difficulté...\nRefais d'autres niveaux.");
      }
    }else{
      # Dans le cas où la difficulté Normal est débloquée
      if(@difficulte == 1 && @@difficuleAcquise[2] == false){
        if(self.assezEtoiles?(2)){
          @@difficuleAcquise[2] = true;
          print("\nBravo tu viens de débloquer la difficulté Hard !");
        }else{
          print("\nTu ne possèdes pas assez d'étoiles pour débloquer cette difficulté...\nRefais d'autres niveaux.");
        }
      }
    }

}
