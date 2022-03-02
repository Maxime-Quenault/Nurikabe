require 'gtk3'
include Gtk

load "Interfaces/FenetreProfil.rb"
load "Interfaces/FenetreLibre.rb"
load "Parametre/AffichageParametre.rb"
load "Sauvegarde/Profil.rb"
load "Interfaces/FenetreAPropos.rb"
#load "Aventure/AffichageAventure.rb"

class FenetreMenu

    attr_accessor :profil, :quit
    def initialize
        Gtk.init 
        @quit = false
        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/menu.glade")

        @interfaceAPropos = FenetreAPropos.new

        @interfaceLibre = FenetreLibre.new
        #@interfaceAventure = AffichageAventure.new
        @interfaceProfil = FenetreProfil.new
        @interfaceProfil.afficheToi
        if @interfaceProfil.quit
            @quit = true
        end
        @profil = @interfaceProfil.profil

        @interfaceParametre = AffichageParametre.new
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

        boxWindow = @builder.get_object("boxWindow")

        #Gestion des signaux
        mainWindow.signal_connect('destroy') {Gtk.main_quit}
        btn_libre.signal_connect('clicked') {
            mainWindow.hide
            @interfaceLibre.afficheToi
            mainWindow.show_all
        }
        btn_survie.signal_connect('clicked') {print "tu as clique sur le mode survie\n"}
        btn_contre_montre.signal_connect('clicked') {print "tu as clique sur le mode contre la montre\n"}

        btn_aventure.signal_connect('clicked') {
            mainWindow.hide
            #@interfaceAventure.afficheToi
            mainWindow.show_all
        }
        btn_tuto.signal_connect('clicked') {print "tu as clique sur le mode tuto\n"}
        btn_propos.signal_connect('clicked') {
            boxWindow.hide
            @interfaceAPropos.afficheToi
            boxWindow.show_all
        }
        btn_parametre.signal_connect('clicked') {
            mainWindow.hide
            @interfaceParametre.afficheLesParametres
            mainWindow.show_all
        }

        #affichage de la fenetre
        mainWindow.show_all

        Gtk.main
    end
end