require 'gtk3'
include Gtk

load "./Partie/Partie.rb"
load "./Interfaces/Fenetre.rb"

class FenetreGrilleCLM < FenetreGrille
    @fenetreClassement
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


    # Créer une table de boutons correspondants aux cases de la grille
    def construction
        @affChrono = Gtk::Label.new()
        @object.add(@affChrono)
        super
        @builder.get_object('btn_retour').signal_connect('clicked'){#quitter
            @object.remove(@affChrono)
        }
        @@partie.chronometre.demarre
        actualiseChrono
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
                        if @@partie.partieFinie?
                            @temps = @@partie.chronometre.getTemps.round()
                            @fenetreClassement.ajoutScore
                            affiche_victoire
                            puts "Bien joué, la partie est finie !"
                            @object.remove(tableFrame)
                            @object.remove(@affChrono)
                            @@partie.raz
                            #@@profilActuel.ajouterPartie(@@partie)
                            self.changerInterface(@menuParent, "Libre")
                        end
                    end
                }
            end
        end
    end

    def actualiseChrono
        Thread.new{
            while !@@partie.partieFinie?
                sleep(0.1)
                @affChrono.set_label(@@partie.chronometre.getTemps.round(1).to_s)
            end
        } 
    end

    def getTempsPartie
        if @@partie.partieFinie?
            return @temps
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