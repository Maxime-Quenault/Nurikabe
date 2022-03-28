require 'gtk3'
include Gtk

load "./Partie/Partie.rb"
load "./Interfaces/Fenetre.rb"
load "Interfaces/FenetreGrille.rb"
load "Chrono/ChronometreSurvie.rb"

class FenetreGrilleSurvie < FenetreGrille
    @fenetreClassement
    @threadChrono
    attr_accessor :object

    def initialize(menuParent, fenetreClassement)
        super(menuParent)
        @fenetreClassement=fenetreClassement
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
    end

     # Changes la couleur des boutons lorsqu'on clique dessus
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
                        if @@partie.partieFinie? # si la grille est finie, on passe à une autre au hasard
                            temp = @@partie.chronometre
                            g=Grille.creer()
                            g.difficulte=rand(3)
                            g.chargerGrille(rand(10),g.difficulte)
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
        @affChrono = Gtk::Label.new()
        @object.add(@affChrono)
        @object.show_all
        super
        @builder.get_object('btn_retour').signal_connect('clicked'){#quitter
            @object.remove(@affChrono)
            @@partie.chronometre.metEnPause
        }
        @@partie.chronometre.demarre
        actualiseChrono
    end

    def actualiseChrono
        if @threadChrono==nil
            @threadChrono = Thread.new{
                while @@partie.chronometre.getTemps.round(1)>0
                    sleep(0.1)
                    @affChrono.set_label(@@partie.chronometre.getTemps.round(1).to_s)
                    puts(@@partie.chronometre.getTemps.round(1).to_s)
                end
                affiche_fin
                @temps = @@partie.chronometre.getTemps.round()
                @fenetreClassement.ajoutScore
                @object.remove(tableFrame)
                @object.remove(@affChrono)
                @@partie.raz
                #@@profilActuel.ajouterPartie(@@partie)
                self.changerInterface(@menuParent, "Libre")
            } 
        end
    end
end