require 'gtk3'
include Gtk
load "Interfaces/FenetreProfil.rb"
load "Sauvegarde/Profil.rb"

class FenetreMenu

    attr_accessor :profil
    def initialize
        Gtk.init 
        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/menu.glade")

        @interfaceProfil = FenetreProfil.new
        @profil = @interfaceProfil.afficheToi

    end


    def afficheToi
        print "profil = #{@profil}\n"
        #Recuperation de la fenetre
        mainWindow = @builder.get_object("mainWindow")

        #Recuperation des variables bouton
        btn_libre = @builder.get_object("btn_libre")
        btn_survie = @builder.get_object("btn_survie")
        btn_contre_montre = @builder.get_object("btn_contre_montre")
        btn_aventure = @builder.get_object("btn_aventure")
        btn_tuto = @builder.get_object("btn_tuto")
        btn_propos = @builder.get_object("btn_propos")
        btn_parametre = @builder.get_object("btn_parametre")

        #Gestion des signaux
        mainWindow.signal_connect('destroy') {Gtk.main_quit}
        btn_libre.signal_connect('clicked') {print "tu as clique sur le mode libre\n"}
        btn_survie.signal_connect('clicked') {print "tu as clique sur le mode survie\n"}
        btn_contre_montre.signal_connect('clicked') {print "tu as clique sur le mode contre la montre\n"}
        btn_aventure.signal_connect('clicked') {print "tu as clique sur le mode aventure\n"}
        btn_tuto.signal_connect('clicked') {print "tu as clique sur le mode tuto\n"}
        btn_propos.signal_connect('clicked') {print "tu as clique sur le mode a propos\n"}
        btn_parametre.signal_connect('clicked') {print "tu as clique sur le mode parametre\n"}

        #affichage de la fenetre
        mainWindow.show_all

        Gtk.main
    end
end