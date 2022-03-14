require 'gtk3'
include Gtk

load "./Partie/Partie.rb"
load "./Sauvegarde/SauvegardeProfil.rb"
load "./Interfaces/FenetreProfil.rb"
load "./Interfaces/Fenetre.rb"

class FenetreGrille < Fenetre

    attr_accessor :profil

    def initialize(inter)
        self.initialiseToi

        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/grille.glade")
        @object = @builder.get_object("menu")

        @grid = @builder.get_object("grille")

        @interfaceRetour = #modifier
        @profil = #modifier

        self.gestionSignaux
    end

    def gestionSignaux #modifier
        
        #Recuperation de la fenetre
        mainWindow = @builder.get_object('grilleWindow')
        grille_aff = @builder.get_object('grille_aff')
        temps_aff = @builder.get_object('temps_aff')
        btn_retour = @builder.get_object('btn_retour')
        btn_undo = @builder.get_object('btn_undo')
        btn_redo = @builder.get_object('btn_redo')
        btn_pause = @builder.get_object('btn_pause')

        #Gestion des signaux
        mainWindow.signal_connect('destroy') {Gtk.main_quit}
        btn_retour.signal_connect('clicked'){
            mainWindow.quit
            @interfaceRetour.afficheToi
        }
        btn_redo.signal_connect('clicked'){#retour

        }
        btn_undo.signal_connect('clicked'){#refaire
            
        }
        btn_pause.signal_connect('clicked'){#stop/continue temps
            
        }

    end
end