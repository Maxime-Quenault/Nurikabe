require 'gtk3'
include Gtk
load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"

class FenetreProfil

    attr_accessor :save,:profil

    def initialize
        @save = SauvegardeProfil.new
    end

    def afficheToi


        ##################################
        ## FONCTION BASIQUE DE CREATION ##
        #Gtk.init
        #Ne pas oublier cela sinon ca plante grave
        #Gtk.init 
        monApplication = Window.new
        monApplication.set_title("Choix profil")
        monApplication.border_width=5
        # On ne peut pas redimensionner
        monApplication.set_resizable(false)
        # L'application est toujours centrée
        monApplication.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
        # Quand l'UI est détruite il faut quitter
        monApplication.signal_connect('destroy') {Gtk.main_quit}
        ##################################


        

        ####################################
        ## CREATION DES BOX DE LA FENÊTRE ##
        monApplication.add(laFenetrePrincipale=Gtk::Box.new(:vertical, (@save.nbProfil + 1) ) )
        laFenetrePrincipale.add(haut=Gtk::Box.new(:horizontal, 2 ) )
        ####################################





        ###################################
        ## CREATION BOUTON + ZONE SAISIE ##

        zoneText = Entry.new
        haut.add(zoneText)

        boutonValider = Button.new(:label => "Valider")
        haut.add(boutonValider)

        if @save.nbProfil != 0
            @save.listeProfil.each do |key, value|
                boutonProfil = Button.new(:label => key.pseudo)
                laFenetrePrincipale.add(boutonProfil)
                boutonProfil.signal_connect('clicked'){
                    @profil = @save.chargerProfil(key.pseudo)
                    event(monApplication)
                }
            end
        end 
        ###################################



        ############################################
        ## GESTION SIGNAL DE CLIQUE SUR LE BOUTON ##

        boutonValider.signal_connect('clicked') {
            pseudo = zoneText.text.to_s
            if pseudo.length != 0
                @profil = Profil.new(pseudo)
                if @save.ajoutProfil(profil) == -1
                    @profil = @save.chargerProfil(pseudo)
                end
                event(monApplication)
            end
        }
        ############################################

        
        #############################
        ## AFFICHAGE DE LA FENETRE ##
        monApplication.show_all
        #############################


        def event(monApplication)
            monApplication.hide
            Gtk.main_quit  
        end

        Gtk.main           
    end

end