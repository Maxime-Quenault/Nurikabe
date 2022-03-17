require 'gtk3'
include Gtk

load "./Interfaces/Fenetre.rb"
load "./Interfaces/FenetreGrille.rb"

class FenetreChoixGrille < Fenetre

    attr_accessor :object
    attr :difficulte, true

    def initialize(menuParent)
        self.initialiseToi
        @difficulte
        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/menu-choix-grille.glade")
        @object = @builder.get_object("menu")
        @boutons
        @menuParent = menuParent
        @interfaceGrille = FenetreGrille.new(@object)
        self.gestionSignaux
    end

    def gestionSignaux
        
        #Recuperation de la fenetre
        btn_retour = @builder.get_object('btn_retour')
        btn1 = @builder.get_object('btn1')
        btn2 = @builder.get_object('btn2')
        btn3 = @builder.get_object('btn3')
        btn4 = @builder.get_object('btn4')
        btn5 = @builder.get_object('btn5')


        #Gestion des signaux
        btn_retour.signal_connect('clicked'){#quitter
            self.changerInterface(@menuParent, "Libre")
        }
        btn1.signal_connect('clicked'){#quitter
            construction(0)
            self.changerInterface(@interfaceGrille.object, "Partie")
        }
        btn2.signal_connect('clicked'){#quitter
            construction(1)
            self.changerInterface(@interfaceGrille.object, "Partie")
        }
        btn3.signal_connect('clicked'){#quitter
            construction(2)
            self.changerInterface(@interfaceGrille.object, "Partie")
        }
        btn4.signal_connect('clicked'){#quitter
            construction(3)
            self.changerInterface(@interfaceGrille.object, "Partie")
        }
        btn5.signal_connect('clicked'){#quitter
            construction(4)
            self.changerInterface(@interfaceGrille.object, "Partie")
        }
    end


    #Créer une table de boutons correspondants aux cases de la grille
    def construction(num_grille)
        if (unePartie = @@profilActuel.chercherPartie(num_grille)) == nil
            g=Grille.creer()
            g.chargerGrille(num_grille,@difficulte)
            creerPartie(g)
        else
            print "\ntu as une partie de save"
            @@partie = unePartie
        end
        @interfaceGrille.construction
    end

end

=begin
if @@partie.grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
    table.attach(Button.new(:label=> (@@partie.grilleEnCours.matriceCases[i][j].valeur).to_s), i, i+1, j, j+1)
else
    table.attach(Button.new(:label=> ""), i, i+1, j, j+1)
end
=end