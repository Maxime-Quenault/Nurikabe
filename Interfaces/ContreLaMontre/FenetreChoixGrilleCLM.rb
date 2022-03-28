require 'gtk3'
include Gtk

load "./Interfaces/Fenetre.rb"
load "./Interfaces/ContreLaMontre/FenetreGrilleCLM.rb"
load "Sauvegarde/SauvegardeClassementContreLaMontre.rb"
load "Interfaces/ContreLaMontre/FenetreClassementCLM.rb"

class FenetreChoixGrilleCLM < Fenetre

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
        @interfaceClassement = FenetreClassementCLM.new(@object)

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
        btn6 = @builder.get_object('btn6')
        btn7 = @builder.get_object('btn7')
        btn8 = @builder.get_object('btn8')
        btn9 = @builder.get_object('btn9')
        btn10 = @builder.get_object('btn10')


        #Gestion des signaux
        btn_retour.signal_connect('clicked'){#quitter
            self.changerInterface(@menuParent, "Libre")
        }
        btn1.signal_connect('clicked'){#quitter
            self.setNumGrille(0)
            construction(0)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
        }
        btn2.signal_connect('clicked'){#quitter
            self.setNumGrille(1)
            construction(1)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
        }
        btn3.signal_connect('clicked'){#quitter
            self.setNumGrille(2)
            construction(2)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
        }
        btn4.signal_connect('clicked'){#quitter
            self.setNumGrille(3)
            construction(3)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
        }
        btn5.signal_connect('clicked'){#quitter
            self.setNumGrille(4)
            construction(4)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
        }
        btn6.signal_connect('clicked'){#quitter
            self.setNumGrille(5)
            construction(5)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
        }
        btn7.signal_connect('clicked'){#quitter
            self.setNumGrille(6)
            construction(6)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
        }
        btn8.signal_connect('clicked'){#quitter
            self.setNumGrille(7)
            construction(7)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
        }
        btn9.signal_connect('clicked'){#quitter
            self.setNumGrille(8)
            construction(8)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
        }
        btn10.signal_connect('clicked'){#quitter
            self.setNumGrille(9)
            construction(9)
            @interfaceClassement.recupeTab
            self.changerInterface(@interfaceClassement.object, "Partie")
        }
    end


    #Créer une table de boutons correspondants aux cases de la grille
    def construction(num_grille)
        if (unePartie = @@profilActuel.chercherPartie(num_grille, @difficulte)) == nil
            g=Grille.creer()
            g.difficulte=@difficulte
            g.chargerGrille(num_grille,@difficulte)
            creerPartie(g)
        else
            print "\ntu as une partie de save"
            @@partie = unePartie
        end
        #@interfaceClassement.construction
    end

end

=begin
if @@partie.grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
    table.attach(Button.new(:label=> (@@partie.grilleEnCours.matriceCases[i][j].valeur).to_s), i, i+1, j, j+1)
else
    table.attach(Button.new(:label=> ""), i, i+1, j, j+1)
end
=end