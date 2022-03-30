require 'gtk3'
include Gtk

load "./Partie/Partie.rb"
load "./Interfaces/Fenetre.rb"
load "Interfaces/FenetreGrille.rb"
load "Chrono/ChronometreSurvie.rb"

class FenetreGrilleSurvie < FenetreGrille
    @fenetreClassement
    @threadChrono
    @grillesDejaFaites
    attr_accessor :object

    def initialize(menuParent, fenetreClassement)
        super(menuParent)
        @fenetreClassement=fenetreClassement
        @grillesDejaFaites = Array.new
    end

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
        @builder.get_object('btn_clear').signal_connect('clicked'){#remet la partie a zero
            @@partie.razSurvie
            #@@partie.chronometre.demarre
            #actualiseChrono
        }
    end

     # Changes la couleur des boutons lorsqu'on clique dessus
     def signaux_boutons(tableFrame)
        @tableFrame=tableFrame
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
                        if @@partie.partieFinie? # si la grille est finie, on passe à une autre au hasard
                            temp = @@partie.chronometre
                            g=Grille.creer()
                            g.difficulte=@@partie.grilleEnCours.difficulte
                            numGrille = rand(10)
                            while (@grillesDejaFaites.include?([numGrille,g.difficulte]))
                                numGrille = rand(10)
                            end
                            g.chargerGrille(numGrille,g.difficulte)
                            creerPartie(g)
                            @@partie.chronometre=temp
                            @object.remove(tableFrame)
                            @object.remove(@affChrono)
                            
                            construction
                        end
                    end
                }
            end
        end
    end

     # Affiche une popup de fin de partie
   def affiche_fin
    dialog = Gtk::Dialog.new
    dialog.title = "Fin"
    dialog.set_default_size(300, 100)
    dialog.child.add(Gtk::Label.new("Le temps est écoulé !"))
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

     # Créer un label pour le chronometre
     def construction
        if !@grillesDejaFaites.include?([@@partie.grilleEnCours.numero,@@partie.grilleEnCours.difficulte])
            @grillesDejaFaites << [@@partie.grilleEnCours.numero, @@partie.grilleEnCours.difficulte]
        end
        if @@partie.chronometre.temps<=0
            puts "\n1"
            @@partie.chronometre=ChronometreSurvie.creer
        end
       
        @affChrono = Gtk::Label.new()
        @object.add(@affChrono)
        @object.show_all
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
        @object.add(tableFrame)
        tableFrame.show_all
         # supprime les boutons et changes d'interface quand on fait retour
        @builder.get_object('btn_retour').signal_connect('clicked'){#quitter
            @object.remove(@affChrono)
            @@partie.chronometre.metEnPause
            @object.remove(tableFrame)
            self.changerInterface(@menuParent, "Survie")
            puts "\n2"
        }
        puts "\n3"
        @@partie.chronometre.demarre
        actualiseChrono
    end

    def actualiseChrono
        if @threadChrono==nil
            @threadChrono = Thread.new{
                while @@partie.chronometre.getTemps.round(1)>0
                    sleep(0.1)
                    @affChrono.set_label(@@partie.chronometre.getTemps.round(1).to_s)
                end
                puts "\n4"
                affiche_fin
                @fenetreClassement.ajoutScore
                @object.remove(@tableFrame)
                @object.remove(@affChrono)
                @@partie.raz
                self.changerInterface(@menuParent, "Survie")
                @threadChrono=nil
            } 
        end
    end

    def getNbGrilles
        @grillesDejaFaites.length-1
    end
end