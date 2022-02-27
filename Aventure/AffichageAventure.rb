require "yaml.rb"
require 'gtk3'
include Gtk
load "Aventure.rb"

class AffichageAventure

  def destruction
    Gtk.main_quit
    return
  end

  def getCouleurGeneral
    return @couleurBase
  end

  def setCouleurGeneral(couleur)
    @couleurBase = couleur
  end

  def getCouleurSecondaire
    return @couleurVisible
  end

  def setCouleurSecondaire(couleur)
    @couleurVisible = couleur
  end

  def setBackground(bouton, couleur)
    bouton.bg = couleur
  end

  def affichageImage
    if(aventure.getEtoileCourante() == 0)
      gtk_image_set_from_file (@image,"../Image/grilleVide.png")
    else
      gtk_image_set_from_file (@image,"../Image/grillePleine.png")
    end
  end

  def affichageEtoile(nbEtoiles)
    case nbEtoiles
    when 0
      imgEtoile1 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile2 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile3 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile4 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile5 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
    when 1
      imgEtoile1 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile2 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile3 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile4 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile5 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
    when 2
      imgEtoile1 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile2 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile3 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile4 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile5 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
    when 3
      imgEtoile1 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile2 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile3 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile4 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
      imgEtoile5 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
    when 4
      imgEtoile1 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile2 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile3 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile4 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile5 = gtk_image_new_from_file ("../Image/etoile_sombre.png")
    when 5
      imgEtoile1 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile2 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile3 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile4 = gtk_image_new_from_file ("../Image/etoile2.png")
      imgEtoile5 = gtk_image_new_from_file ("../Image/etoile2.png")
    end
  end

  def boutonSuivPreced
    case(aventure.getPosCourante())
    when 0
      self.pack_start(bouton1)
      break
    when 1
      self.pack_start(bouton2)
      break
    when 2
      self.pack_start(bouton3)
      break
    when 3
      self.pack_start(bouton4)
      break
    when 4
      self.pack_start(bouton5)
      break
    when 5
      self.pack_start(bouton6)
      break
    when 6
      self.pack_start(bouton7)
      break
    when 7
      self.pack_start(bouton8)
      break
    when 8
      self.pack_start(bouton9)
      break
    when 9
      self.pack_start(bouton10)
      break
    end
  end

  @couleurBase = "white"
  @couleurVisible = "grey"
  @image = gtk_image_new_from_file("../Image/grilleVide.png")

  monBuildeur = Gtk::Builder.new()
  monBuildeur.add_from_file("../glade/aventure_normal_img.glade")

  aventureFacile.generationAventure(10)
  aventureNormale.generationAventure(10)
  aventureHard.generationAventure(10)

  aventure = Aventure.creer(aventureFacile,aventureNormale,aventureHard)

  bouton1 = monBuildeur.get_object('btn_grille_1')
  bouton2 = monBuildeur.get_object('btn_grille_2')
  bouton3 = monBuildeur.get_object('btn_grille_3')
  bouton4 = monBuildeur.get_object('btn_grille_4')
  bouton5 = monBuildeur.get_object('btn_grille_5')
  bouton6 = monBuildeur.get_object('btn_grille_6')
  bouton7 = monBuildeur.get_object('btn_grille_7')
  bouton8 = monBuildeur.get_object('btn_grille_8')
  bouton9 = monBuildeur.get_object('btn_grille_9')
  bouton10 = monBuildeur.get_object('btn_grille_10')

  modeFacile = monBuildeur.get_object('btn_facile')
  modeNormal = monBuildeur.get_object('btn_normal')
  modeHard = monBuildeur.get_object('btn_difficile')

  btnPreced = monBuildeur.get_object('btn_grille_preced')
  btnSuivant = monBuildeur.get_object('btn_grille_suiv')

  imgEtoile1 = monBuildeur.get_object('etoile_1')
  imgEtoile2 = monBuildeur.get_object('etoile_2')
  imgEtoile3 = monBuildeur.get_object('etoile_3')
  imgEtoile4 = monBuildeur.get_object('etoile_4')
  imgEtoile5 = monBuildeur.get_object('etoile_5')

  fenetre = monBuilder.get_object('fenetre_aventure')

  fenetre.signal_connect('btn_retour') {
    self.destruction()
  }

  fenetre.signal_connect('btn_grille_preced') {
    aventure.grillePrecedente()
    self.boutonSuivPreced()
  }

  fenetre.signal_connect('btn_grille_suiv') {
    aventure.prochaineGrille()
    self.boutonSuivPreced()
  }

  fenetre.signal_connect('btn_facile') {
    aventure.choixDifficulte(0)
    aventure.placerSurGrille(0)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(modeFacile,@couleurVisible)
    self.setBackground(modeNormal,@couleurBase)
    self.setBackground(modeHard,@couleurBase)
  }
  
  fenetre.signal_connect('btn_normal') {
    aventure.choixDifficulte(1)
    aventure.unlockDifficulte()
    aventure.placerSurGrille(0)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(modeFacile,@couleurBase)
    self.setBackground(modeNormal,@couleurVisible)
    self.setBackground(modeHard,@couleurBase)
  }

  fenetre.signal_connect('btn_difficile') {
    aventure.choixDifficulte(2)
    aventure.unlockDifficulte()
    aventure.placerSurGrille(0)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(modeFacile,@couleurBase)
    self.setBackground(modeNormal,@couleurBase)
    self.setBackground(modeHard,@couleurVisible)
  }

  fenetre.signal_connect('img_grille') {
    # Ajouter méthode de lancement de la partie
  }

  fenetre.signal_connect('btn_grille_1') {
    aventure.placerSurGrille(0)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(bouton1,@couleurVisible)
    self.setBackground(bouton2,@couleurBase)
    self.setBackground(bouton3,@couleurBase)
    self.setBackground(bouton4,@couleurBase)
    self.setBackground(bouton5,@couleurBase)
    self.setBackground(bouton6,@couleurBase)
    self.setBackground(bouton7,@couleurBase)
    self.setBackground(bouton8,@couleurBase)
    self.setBackground(bouton9,@couleurBase)
    self.setBackground(bouton10,@couleurBase)
  }

  fenetre.signal_connect('btn_grille_2') {
    aventure.placerSurGrille(1)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(bouton1,@couleurBase)
    self.setBackground(bouton2,@couleurVisible)
    self.setBackground(bouton3,@couleurBase)
    self.setBackground(bouton4,@couleurBase)
    self.setBackground(bouton5,@couleurBase)
    self.setBackground(bouton6,@couleurBase)
    self.setBackground(bouton7,@couleurBase)
    self.setBackground(bouton8,@couleurBase)
    self.setBackground(bouton9,@couleurBase)
    self.setBackground(bouton10,@couleurBase)
  }

  fenetre.signal_connect('btn_grille_3') {
    aventure.placerSurGrille(2)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(bouton1,@couleurBase)
    self.setBackground(bouton2,@couleurBase)
    self.setBackground(bouton3,@couleurVisible)
    self.setBackground(bouton4,@couleurBase)
    self.setBackground(bouton5,@couleurBase)
    self.setBackground(bouton6,@couleurBase)
    self.setBackground(bouton7,@couleurBase)
    self.setBackground(bouton8,@couleurBase)
    self.setBackground(bouton9,@couleurBase)
    self.setBackground(bouton10,@couleurBase)
  }

  fenetre.signal_connect('btn_grille_4') {
    aventure.placerSurGrille(3)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(bouton1,@couleurBase)
    self.setBackground(bouton2,@couleurBase)
    self.setBackground(bouton3,@couleurBase)
    self.setBackground(bouton4,@couleurVisible)
    self.setBackground(bouton5,@couleurBase)
    self.setBackground(bouton6,@couleurBase)
    self.setBackground(bouton7,@couleurBase)
    self.setBackground(bouton8,@couleurBase)
    self.setBackground(bouton9,@couleurBase)
    self.setBackground(bouton10,@couleurBase)
  }

  fenetre.signal_connect('btn_grille_5') {
    aventure.placerSurGrille(4)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(bouton1,@couleurBase)
    self.setBackground(bouton2,@couleurBase)
    self.setBackground(bouton3,@couleurBase)
    self.setBackground(bouton4,@couleurBase)
    self.setBackground(bouton5,@couleurVisible)
    self.setBackground(bouton6,@couleurBase)
    self.setBackground(bouton7,@couleurBase)
    self.setBackground(bouton8,@couleurBase)
    self.setBackground(bouton9,@couleurBase)
    self.setBackground(bouton10,@couleurBase)
  }

  fenetre.signal_connect('btn_grille_6') {
    aventure.placerSurGrille(5)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(bouton1,@couleurBase)
    self.setBackground(bouton2,@couleurBase)
    self.setBackground(bouton3,@couleurBase)
    self.setBackground(bouton4,@couleurBase)
    self.setBackground(bouton5,@couleurBase)
    self.setBackground(bouton6,@couleurVisible)
    self.setBackground(bouton7,@couleurBase)
    self.setBackground(bouton8,@couleurBase)
    self.setBackground(bouton9,@couleurBase)
    self.setBackground(bouton10,@couleurBase)
  }

  fenetre.signal_connect('btn_grille_7') {
    aventure.placerSurGrille(6)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(bouton1,@couleurBase)
    self.setBackground(bouton2,@couleurBase)
    self.setBackground(bouton3,@couleurBase)
    self.setBackground(bouton4,@couleurBase)
    self.setBackground(bouton5,@couleurBase)
    self.setBackground(bouton6,@couleurBase)
    self.setBackground(bouton7,@couleurVisible)
    self.setBackground(bouton8,@couleurBase)
    self.setBackground(bouton9,@couleurBase)
    self.setBackground(bouton10,@couleurBase)
  }

  fenetre.signal_connect('btn_grille_8') {
    aventure.placerSurGrille(7)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(bouton1,@couleurBase)
    self.setBackground(bouton2,@couleurBase)
    self.setBackground(bouton3,@couleurBase)
    self.setBackground(bouton4,@couleurBase)
    self.setBackground(bouton5,@couleurBase)
    self.setBackground(bouton6,@couleurBase)
    self.setBackground(bouton7,@couleurBase)
    self.setBackground(bouton8,@couleurVisible)
    self.setBackground(bouton9,@couleurBase)
    self.setBackground(bouton10,@couleurBase)
  }

  fenetre.signal_connect('btn_grille_9') {
    aventure.placerSurGrille(8)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(bouton1,@couleurBase)
    self.setBackground(bouton2,@couleurBase)
    self.setBackground(bouton3,@couleurBase)
    self.setBackground(bouton4,@couleurBase)
    self.setBackground(bouton5,@couleurBase)
    self.setBackground(bouton6,@couleurBase)
    self.setBackground(bouton7,@couleurBase)
    self.setBackground(bouton8,@couleurBase)
    self.setBackground(bouton9,@couleurVisible)
    self.setBackground(bouton10,@couleurBase)
  }

  fenetre.signal_connect('btn_grille_10') {
    aventure.placerSurGrille(9)
    self.affichageEtoile(aventure.getEtoileCourante())
    self.affichageImage()
    self.setBackground(bouton1,@couleurBase)
    self.setBackground(bouton2,@couleurBase)
    self.setBackground(bouton3,@couleurBase)
    self.setBackground(bouton4,@couleurBase)
    self.setBackground(bouton5,@couleurBase)
    self.setBackground(bouton6,@couleurBase)
    self.setBackground(bouton7,@couleurBase)
    self.setBackground(bouton8,@couleurBase)
    self.setBackground(bouton9,@couleurBase)
    self.setBackground(bouton10,@couleurVisible)
  }

end
