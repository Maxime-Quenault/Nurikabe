require 'gtk3'
include Gtk

class InterfaceMenu

    def initialize
        Gtk.init 
        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/menu.glade")

    end


    def afficheToi
        
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

        #affichage de la fenetre
        mainWindow.show_all

        Gtk.main
    end
end