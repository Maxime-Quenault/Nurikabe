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

        #Gestion Graphique CSS
        btn_retour.name = "btn_menu_grille"
        btn_undo.name = "btn_menu_grille_grise"
        btn_redo.name = "btn_menu_grille_grise"
        btn_pause.name = "btn_menu_grille"
        btn_rembobiner.name = "btn_menu_grille_grise"
        btn_clear.name = "btn_menu_grille"
        btn_aide.name = "btn_menu_grille"

        #Gestion des signaux
        btn_redo.signal_connect('clicked'){#redo
            @@partie.redo
            maj_boutons
            griserBoutons
            puts @@partie.grilleEnCours
        }
        btn_undo.signal_connect('clicked'){#undo
            @@partie.undo
            maj_boutons
            griserBoutons
            puts @@partie.grilleEnCours
        }
        btn_rembobiner.signal_connect('clicked'){#retour tant qu'il y a des erreurs
            @@partie.reviensALaBonnePosition()
            maj_boutons
            griserBoutons
            puts @@partie.grilleEnCours
        }
        btn_aide.signal_connect('clicked'){#affiche un indice
            indice=@@partie.clicSurIndice
            puts indice
            if indice==@@partie.dernierIndice
                @boutons[[indice.coordonneesCase[0],indice.coordonneesCase[1]]].name = "case_indice"
            end
            affiche_indice(indice)
            @@partie.dernierIndice=indice
            
        }
        btn_clear.signal_connect('clicked'){#remet la partie a zero
            @@partie.raz
            griserBoutons
            maj_boutons
            puts @@partie.grilleEnCours
        }
        

    end

    # Affiche une popup avec l'indice
    def affiche_indice(indice)
        dialog = Gtk::Dialog.new
        dialog.title = "Indice"
        dialog.set_default_size(300, 100)
        dialog.child.add(Gtk::Label.new(indice.to_s))
        dialog.add_button(Gtk::Stock::CLOSE, Gtk::ResponseType::CLOSE)
        dialog.set_default_response(Gtk::ResponseType::CANCEL)

        dialog.signal_connect("response") do |widget, response|
            case response
            when Gtk::ResponseType::CANCEL
            p "Cancel"
            when Gtk::ResponseType::CLOSE
            p "Close"
            dialog.destroy
            end
        end
        dialog.show_all
    end

   # Affiche une popup de victoire
   def affiche_victoire
    dialog = Gtk::Dialog.new
    dialog.title = "Victoire"
    dialog.set_default_size(300, 100)
    dialog.child.add(Gtk::Label.new("Bravo, vous avez résolu le puzzle !"))
    dialog.add_button(Gtk::Stock::CLOSE, Gtk::ResponseType::CLOSE)
    dialog.set_default_response(Gtk::ResponseType::CANCEL)

    dialog.signal_connect("response") do |widget, response|
        case response
        when Gtk::ResponseType::CANCEL
        p "Cancel"
        when Gtk::ResponseType::CLOSE
        p "Close"
        dialog.destroy
        end
    end
    dialog.show_all
end

    # Créer une table de boutons correspondants aux cases de la grille
    def construction
        taille_hauteur = @@partie.grilleEnCours.hauteur
        taille_largeur = @@partie.grilleEnCours.largeur
        @boutons = {}
        tableFrame = Frame.new();
        tableFrame.name = "grille"
        table = Table.new(taille_hauteur,taille_largeur,false)
        table.set_halign(3);
        table.set_valign(3);
        tableFrame.set_halign(3);
        tableFrame.set_valign(3);
        tableFrame.add(table)
        for i in 0..taille_largeur-1
            for j in 0..taille_hauteur-1
                if @@partie.grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
                    @boutons[[i,j]] = Button.new(:label=> @@partie.grilleEnCours.matriceCases[i][j].to_s)
                    @boutons[[i,j]].name = "case_chiffre"
                    table.attach(@boutons[[i,j]], i, i+1, j, j+1)
                else
                    @boutons[[i,j]] = Button.new()
                    @boutons[[i,j]].name = "case_vide"
                    table.attach(@boutons[[i,j]], i, i+1, j, j+1)
                end
            end
        end
        maj_boutons
        signaux_boutons(tableFrame)
        @object.add(table)
        # supprime les boutons
        @builder.get_object('btn_retour').signal_connect('clicked'){#quitter
            @object.remove(tableFrame)
            @@profilActuel.ajouterPartie(@@partie)
            self.changerInterface(@menuParent, "Libre")
        }
        @object.add(tableFrame)
    end

	# Créer un affichage de la grille pour la librarie de grille
    def afficheGrille(hauteur, largeur)
        taille_hauteur = hauteur
        taille_largeur = largeur
        @boutons = {}
        tableFrame = Frame.new();
        tableFrame.name = "grille_preview"
        table = Table.new(taille_hauteur,taille_largeur,false)
        table.set_halign(3);
        table.set_valign(3);
        tableFrame.set_halign(3);
        tableFrame.set_valign(3);
        tableFrame.add(table)
        for i in 0..taille_largeur-1
            for j in 0..taille_hauteur-1
				@boutons[[i,j]] = Button.new()
				@boutons[[i,j]].name = "case_vide_preview"
				table.attach(@boutons[[i,j]], i, i+1, j, j+1)
            end
        end
        # maj_boutons
        # signaux_boutons(tableFrame)
        # @object.add(table)
		
        # # supprime les boutons
        # @builder.get_object('btn_retour').signal_connect('clicked'){#quitter
        #     @object.remove(tableFrame)
        #     @@profilActuel.ajouterPartie(@@partie)
        #     self.changerInterface(@menuParent, "Libre")
        # }

        return tableFrame
    end

    # Changes la couleur des boutons lorsqu'on clique dessus
    def signaux_boutons(tableFrame)
        @boutons.each do |cle, val|
            if @@partie.grilleEnCours.matriceCases[cle[0]][cle[1]].is_a?(CaseJouable)
                val.signal_connect('clicked'){
                    @@partie.clicSurCase(cle[0],cle[1])
                    maj_bouton(cle[0],cle[1])
                    griserBoutons
                    if @@partie.dernierIndice!=nil && @@partie.dernierIndice.type!=nil && @@partie.grilleEnCours.matriceCases[@@partie.dernierIndice.coordonneesCase[0]][@@partie.dernierIndice.coordonneesCase[1]].is_a?(CaseNombre)
                        @boutons[[@@partie.dernierIndice.coordonneesCase[0],@@partie.dernierIndice.coordonneesCase[1]]].name = "case_chiffre"
                    end
                    if @@partie.partieFinie?
                        affiche_victoire
                        puts "Bien joué, la partie est finie !"
                        @object.remove(tableFrame)
                        @@profilActuel.ajouterPartie(@@partie)
                        self.changerInterface(@menuParent, "Libre")
                    end
                }
            end
        end
    end

    def griserBoutons
        btn_undo = @builder.get_object('btn_undo')
        btn_redo = @builder.get_object('btn_redo')
        btn_rembobiner = @builder.get_object('btn_rembobiner')
        if @@partie.undoPossible?
            btn_undo.name = "btn_menu_grille"
            btn_rembobiner.name = "btn_menu_grille"
        else 
            btn_undo.name = "btn_menu_grille_grise"
            btn_rembobiner.name = "btn_menu_grille_grise"
        end
        if @@partie.redoPossible?
            btn_redo.name = "btn_menu_grille"
        else 
            btn_redo.name = "btn_menu_grille_grise"
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
        if(@@partie.grilleEnCours.matriceCases[i][j].etat==0)
            @boutons[[i,j]].name = "case_vide"
            @boutons[[i,j]].set_label(" ")
        elsif (@@partie.grilleEnCours.matriceCases[i][j].etat==1)
            @boutons[[i,j]].name = "case_noir"
            @boutons[[i,j]].set_label(" ")
        else
            @boutons[[i,j]].name = "case_point"  
            @boutons[[i,j]].set_label("•")
        end
    end

end

=begin
if @@partie.grilleEnCours.matriceCases[i][j].is_a?(CaseNombre)
    table.attach(Button.new(:label=> (@@partie.grilleEnCours.matriceCases[i][j].valeur).to_s), i, i+1, j, j+1)
else
    table.attach(Button.new(:label=> ""), i, i+1, j, j+1)
end
=end