require 'gtk3'
include Gtk
load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"

class FenetreProfil

    attr_accessor :save,:profil, :quit

    def initialize
        @save = SauvegardeProfil.new
        @quit = false
        @monApplication = Window.new()
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
        @monApplication.set_title("Choix profil")
        @monApplication.border_width=10
        # On ne peut pas redimensionner
        @monApplication.set_resizable(false)
        # L'application est toujours centrée
        @monApplication.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
        # Quand l'UI est détruite il faut quitter
        @monApplication.signal_connect('destroy') {destruction}
        ##################################


        

        ####################################
        ## CREATION DES BOX DE LA FENÊTRE ##
        @monApplication.add(laFenetrePrincipale=Gtk::Box.new(:vertical, (@save.nbProfil + 1) ) )
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
                ligneProfil=Gtk::Box.new(:horizontal, 3) # Box pour l'image du profil, son nom et le bouton supprimer

                imageProfil = Gtk::Image.new(key.imageJoueur)
                ligneProfil.add(imageProfil)     

                boutonProfil = Button.new(:label => key.pseudo)
                boutonProfil.set_width_request(140)
                ligneProfil.add(boutonProfil)

                imageSupprimer = Gtk::Image.new("Image/trash.png")
                boutonSupprimer = Button.new()
                boutonSupprimer.image = imageSupprimer
                boutonSupprimer.set_width_request(60)
                ligneProfil.add(setmargin(boutonSupprimer, 0, 0, 5, 0))

                laFenetrePrincipale.add(ligneProfil)
                
                boutonProfil.signal_connect('clicked'){
                    @profil = @save.chargerProfil(key.pseudo)
                    event(@monApplication)
                }

                boutonSupprimer.signal_connect('clicked'){
                    d = Gtk::MessageDialog.new(@monApplication,
                    Gtk::Dialog::DESTROY_WITH_PARENT,
                    Gtk::MessageDialog::WARNING,
                    Gtk::MessageDialog::BUTTONS_YES_NO,
                    "Voulez-vous supprimer le profil #{key.pseudo} ?")

                    response = d.run

                    case response
                        when Gtk::ResponseType::YES
                            @save.supprimerProfil(key)
                            laFenetrePrincipale.remove(ligneProfil)
                            d.destroy
                        else
                            d.destroy
                    end
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
                if @save.ajoutProfil(profil) != -1
                    @profil = @save.chargerProfil(pseudo)
                else
                    d = Gtk::MessageDialog.new(@monApplication,
                    Gtk::Dialog::DESTROY_WITH_PARENT,
                    Gtk::MessageDialog::WARNING,
                    Gtk::MessageDialog::BUTTONS_CLOSE,
                    "Le pseudo #{pseudo} existe déjà...")

                    d.run
                    d.destroy
                end
            end
        }
        ############################################

        
        #############################
        ## AFFICHAGE DE LA FENETRE ##
        @monApplication.show_all
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