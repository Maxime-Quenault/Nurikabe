require 'gtk3'
include Gtk

load "./Partie/Partie.rb"
load "./Interfaces/Fenetre.rb"

class FenetreGrille < Fenetre

    attr_accessor :object

    def initialize(menuParent)
        self.initialiseToi

        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/grille.glade")
        @object = @builder.get_object("menu")

        @menuParent = menuParent

        self.gestionSignaux
    end

    def gestionSignaux
        
        #Recuperation de la fenetre
        btn_retour = @builder.get_object('btn_retour')
        btn_undo = @builder.get_object('btn_undo')
        btn_redo = @builder.get_object('btn_redo')
        btn_pause = @builder.get_object('btn_pause')
        btn_rembobiner = @builder.get_object('btn_rembobiner')
        btn_clear = @builder.get_object('btn_clear')
        btn_aide = @builder.get_object('btn_aide')

        #Gestion des signaux
        btn_retour.signal_connect('clicked'){#quitter
            self.changerInterface(@menuParent, "Libre")
        }
        btn_redo.signal_connect('clicked'){#retour
            @@partie.redo
            puts @@partie.grilleEnCours
        }
        btn_undo.signal_connect('clicked'){#refaire
            @@partie.undo
            puts @@partie.grilleEnCours
        }
        btn_rembobiner.signal_connect('clicked'){#retour tant qu'il y a des erreurs
            @@partie.reviensALaBonnePosition()
            puts @@partie.grilleEnCours
        }
        btn_aide.signal_connect('clicked'){#affiche un indice
            puts @@partie.clicSurIndice
        }
        btn_clear.signal_connect('clicked'){#remet la partie a zero
            @@partie.raz
            puts @@partie.grilleEnCours
        }
        

    end

    def construction
        taille_hauteur = @@partie.grilleEnCours.hauteur
        taille_largeur = @@partie.grilleEnCours.largeur
        table = Table.new(taille_hauteur,taille_largeur,false)
        for i in 0..taille_largeur-1
            for j in 0..taille_hauteur-1
                table.attach(Button.new(:label=> "i = #{i}: j = #{j}"), i, i+1, j, j+1)
            end
        end
        @object.add(table)
    end

end

=begin
if @@partie.grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
    table.attach(Button.new(:label=> (@@partie.grilleEnCours.matriceCases[i][j].valeur).to_s), i, i+1, j, j+1)
else
    table.attach(Button.new(:label=> ""), i, i+1, j, j+1)
end
=end