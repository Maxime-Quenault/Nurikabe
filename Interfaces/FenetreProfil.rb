require 'gtk3'
include Gtk
load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"

class FenetreProfil

    attr_accessor :save,:profil, :quit

    def initialize
        @save = SauvegardeProfil.new
        @quit = false
    end

    def setmargin(obj, top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end

    def afficheToi


        ##################################
        ## FONCTION BASIQUE DE CREATION ##
        #Gtk.init
        #Ne pas oublier cela sinon ça plante grave
        #Gtk.init 
        monApplication = Window.new
        monApplication.set_title("Choix profil")
        monApplication.border_width=10
        # On ne peut pas redimensionner
        monApplication.set_resizable(false)
        # L'application est toujours centrée
        monApplication.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
        # Quand l'UI est détruite il faut quitter
        monApplication.signal_connect('destroy') {destruction}
        ##################################


        

        ####################################
        ## CREATION DES BOX DE LA FENÊTRE ##
        monApplication.add(laFenetrePrincipale=Gtk::Box.new(:vertical, (@save.nbProfil + 1) ) )
        laFenetrePrincipale.add(haut=Gtk::Box.new(:horizontal, 2))
        ####################################


        ###################################
        ## CREATION BOUTON + ZONE SAISIE ##

        zoneText = Entry.new
        haut.add(setmargin(zoneText, 0, 15, 0, 0))

        imageValider = Gtk::Image.new("Image/valider.png")
        boutonValider = Button.new()
        boutonValider.image = imageValider
        boutonValider.set_width_request(60)
        haut.add(setmargin(boutonValider, 0, 15, 5, 0))

        if @save.nbProfil != 0
            @save.listeProfil.each do |key, value|
                imageSupprimer = Gtk::Image.new("Image/trash.png")
                ligneProfil=Gtk::Box.new(:horizontal, 2)
                boutonProfil = Button.new(:label => key.pseudo)
                boutonProfil.set_width_request(169)
                ligneProfil.add(boutonProfil)
                boutonSupprimer = Button.new()
                boutonSupprimer.image = imageSupprimer
                boutonSupprimer.set_width_request(60)
                ligneProfil.add(setmargin(boutonSupprimer, 0, 0, 5, 0))
                laFenetrePrincipale.add(ligneProfil)
                boutonProfil.signal_connect('clicked'){
                    @profil = @save.chargerProfil(key.pseudo)
                    event(monApplication)
                }
                boutonSupprimer.signal_connect('clicked'){
                    @save.supprimerProfil(key)
                    laFenetrePrincipale.remove(ligneProfil)
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

        def destruction()
            @quit = true
            Gtk.main_quit
        end

        Gtk.main           
    end

end