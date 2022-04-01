require 'gtk3'
include Gtk

load "./Partie/Partie.rb"
load "./Interfaces/Fenetre.rb"
load "Interfaces/FenetreGrille.rb"

class FenetreGrilleCLM < FenetreGrille
    @fenetreClassement
    attr_accessor :object

    ##
	# initialize :
	# 	Cette methode est le constructeur de la classe FenetreGrilleCLM, il permet de recuperer
	#	le fichier glade et tout les objets qui le compose. Ensuite nous attribuons les bonnes 
	#	actions a chaque objets récupérés.
	#
	# @param menuParent represente l'interface parent, elle sera util pour le bouton retour en arrière.
    # @param fenetreClassement represente le classement du mode de jeu
    def initialize(menuParent, fenetreClassement)
        super(menuParent)
        @fenetreClassement=fenetreClassement
    end

    ##
    # gestionSignaux:
    #   Récupère les boutons et créer tout les signaux correspondants
    def gestionSignaux
        super
        #Recuperation de la fenetre
        btn_pause = @builder.get_object('btn_pause')
        #Gestion des signaux
        btn_pause.signal_connect('clicked'){#pause
            if @@partie.chronometre.estEnPause?
                @@partie.chronometre.demarre
            else
                @@partie.chronometre.metEnPause
            end
        }
    end

    ##
    # construction:
    #   Créer une table de boutons correspondants aux cases de la grille
    def construction
        @affChrono = Gtk::Label.new()
        @object.add(@affChrono)
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
        # supprime les boutons et changes d'interface quand on fait retour
        @builder.get_object('btn_retour').signal_connect('clicked'){#quitter
            @object.remove(tableFrame)
            @object.remove(@affChrono)
            @@partie.chronometre.metEnPause
            self.changerInterface(@menuParent, "Libre")
        }
        @object.add(tableFrame)
        tableFrame.show_all
        @@partie.chronometre.demarre
        actualiseChrono
    end

    ##
    # signaux_boutons:
    #   Changes la couleur des boutons lorsqu'on clique dessus
    def signaux_boutons(tableFrame)
        @boutons.each do |cle, val|
            if @@partie.grilleEnCours.matriceCases[cle[0]][cle[1]].is_a?(CaseJouable)
                val.signal_connect('clicked'){
                    if !@@partie.chronometre.estEnPause?
                        @@partie.clicSurCase(cle[0],cle[1])
                        maj_bouton(cle[0],cle[1])
                        griserBoutons
                        if @@partie.dernierIndice!=nil && @@partie.dernierIndice.type!=nil && @@partie.grilleEnCours.matriceCases[@@partie.dernierIndice.coordonneesCase[0]][@@partie.dernierIndice.coordonneesCase[1]].is_a?(CaseNombre)
                            @boutons[[@@partie.dernierIndice.coordonneesCase[0],@@partie.dernierIndice.coordonneesCase[1]]].name = "case_chiffre"
                        end
                        if @@partie.partieFinie?
                            @temps = @@partie.chronometre.getTemps.round()
                            @fenetreClassement.ajoutScore
                            affiche_victoire
                            puts "Bien joué, la partie est finie !"
                            @object.remove(tableFrame)
                            @object.remove(@affChrono)
                            @@partie.raz
                            self.changerInterface(@menuParent, "Libre")
                        end
                    end
                }
            end
        end
    end

    ##
    # actualiseChrono:
    #   permet de gerer le chronometre en parallèle du jeu.
    def actualiseChrono
        Thread.new{
            while !@@partie.partieFinie?
                sleep(0.1)
                @affChrono.set_label(@@partie.chronometre.getTemps.round(1).to_s)
            end
        } 
    end

    ##
    # getTempsPartie
    #   permet de recuêre le temps de la partie seulement quand elle est terminé.
    def getTempsPartie
        if @@partie.partieFinie?
            return @temps
        end
    end

end