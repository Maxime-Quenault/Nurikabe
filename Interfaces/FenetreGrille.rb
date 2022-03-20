require 'gtk3'
include Gtk

load "./Partie/Partie.rb"
load "./Interfaces/Fenetre.rb"

=begin

    La classe FenetreGrille :::
        - génère l'interface d'une partie
        - peut gérer les différents boutons et leur "cliquabilité" (s'ils sont cliquables ou non, en fonction du contexte de la partie)

    Les VI de la classe sont :::
        - @builder          ==> builder de la fenêtre courante
        - @object           ==> contient l'identifiant glade de l'interface courante
        - @grid             ==> contient l'identifiant glade de la grille
        - @interfaceRetour  ==> 
        - @profil           ==> contient le profil courant
        - @menuParent       ==> contient l'interface parente de l'interface courante
        - @boutons          ==> table contenant une liste de boutons
    
    Les VC de la classe sont :::
        - @@partie  ==> partie en cours


=end


class FenetreGrille < Fenetre

    attr_accessor :object

    def initialize(menuParent)
        self.initialiseToi

        @builder = Gtk::Builder.new
        @builder.add_from_file("glade/grille.glade")
        @object = @builder.get_object("menu")

        @grid = @builder.get_object("grille")

        @interfaceRetour = #modifier
        @profil = #modifier
        @boutons
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
        btn_redo.signal_connect('clicked'){#retour
            @@partie.redo
            maj_boutons
            puts @@partie.grilleEnCours
        }
        btn_undo.signal_connect('clicked'){#refaire
            @@partie.undo
            maj_boutons
            puts @@partie.grilleEnCours
        }
        btn_rembobiner.signal_connect('clicked'){#retour tant qu'il y a des erreurs
            @@partie.reviensALaBonnePosition()
            maj_boutons
            puts @@partie.grilleEnCours
        }
        btn_aide.signal_connect('clicked'){#affiche un indice
            puts @@partie.clicSurIndice
        }
        btn_clear.signal_connect('clicked'){#remet la partie a zero
            @@partie.raz
            maj_boutons
            puts @@partie.grilleEnCours
        }
        

    end

    # Créer une table de boutons correspondants aux cases de la grille
    def construction
        taille_hauteur = @@partie.grilleEnCours.hauteur
        taille_largeur = @@partie.grilleEnCours.largeur
        @boutons = {}
        table = Table.new(taille_hauteur,taille_largeur,false)
        for i in 0..taille_largeur-1
            for j in 0..taille_hauteur-1
                if @@partie.grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
                    @boutons[[i,j]] = Button.new(:label=> @@partie.grilleEnCours.matriceCases[i][j].to_s)
                    table.attach(@boutons[[i,j]], i, i+1, j, j+1)
                else
                    @boutons[[i,j]] = Button.new()
                    table.attach(@boutons[[i,j]], i, i+1, j, j+1)
                end
            end
        end
        maj_boutons
        signaux_boutons
        @object.add(table)
        # supprime les boutons
        @builder.get_object('btn_retour').signal_connect('clicked'){#quitter
            @object.remove(table)
            @@partie=nil
            self.changerInterface(@menuParent, "Libre")
        }
    end

    # Changes la couleur des boutons lorsqu'on clique dessus
    def signaux_boutons
        @boutons.each do |cle, val|
            if @@partie.grilleEnCours.matriceCases[cle[0]][cle[1]].is_a?(CaseJouable)
                val.signal_connect('clicked'){
                    @@partie.clicSurCase(cle[0],cle[1])
                    maj_bouton(cle[0],cle[1])
                    if @@partie.partieFinie?
                        puts "Bien joué, la partie est finie !"
                        self.changerInterface(@menuParent, "Libre")
                    end
                }
            end
        end
    end

    def maj_boutons
        @boutons.each do |cle, val|
            if @@partie.grilleEnCours.matriceCases[cle[0]][cle[1]].is_a?(CaseJouable)
                maj_bouton(cle[0],cle[1])
            end
        end
    end

    #Change la couleur d'un bouton aux coordonnées passées en paramètres en fonction de l'état de la case correspondante
    def maj_bouton(i,j)
        lab = if(@@partie.grilleEnCours.matriceCases[i][j].etat==0)
            ""
        elsif (@@partie.grilleEnCours.matriceCases[i][j].etat==1)
            "Noir"
        else
            "Point"
        end
        @boutons[[i,j]].set_label(lab)
    end

end

=begin
if @@partie.grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
    table.attach(Button.new(:label=> (@@partie.grilleEnCours.matriceCases[i][j].valeur).to_s), i, i+1, j, j+1)
else
    table.attach(Button.new(:label=> ""), i, i+1, j, j+1)
end
=end