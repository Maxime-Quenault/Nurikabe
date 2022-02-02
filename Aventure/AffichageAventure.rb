require "yaml.rb"
require 'gtk3'
include Gtk
load "Aventure.rb";

class AffichageAventure

  def destruction
    Gtk.main_quit
    return
  end



  monBuildeur = Gtk::Builder.new();
  monBuildeur.add_from_file("../Modele_Image/aventure_normal_img.glade")
  unBouton = monBuildeur.get_object("bouton1")

  fenetre = monBuilder.get_object("fenetre_aventure")

  fenetre.signal_connect('btn_retourn') {destruction}


end
