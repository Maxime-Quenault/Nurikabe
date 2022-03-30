require 'gtk3'
include Gtk
load "Sauvegarde/SauvegardeProfil.rb"
load "Sauvegarde/Profil.rb"

##
#   @author Trottier Léo / Quenault Maxime
#
#   Cette classe permet de gerer l'affichage de l'interface qui s'occupe des profils.
#   Pour cela elle va creer une nouvelle fenetre et va recupere la liste de tous les profil sauvegardé sur la machine
#   pour les proposer à l'utilisateur. Cette classe est différentes des autres interface car elle est indépendante,
#   et n'utilise pas de fichier glade.
#
#   Voici ses méthodes :
#
#   - initialize : est le constructeur de la classe, il va recuperer la listes des profils sauvegarder et initiliser une fenetre
#   - setmargin : ??? (léo je te laisse ecrire)
#   - afficheToi : permet d'afficher la fenetre avec tous les profils de la sauvegarde, gère egalement la suppresion et la création
#   de nouveau profils.
#   - event : permet de supprimer l'affichage de la fenetre profil quand on a selectionner/créé un profil
#   - destruction : permet de supprimer la fenetre si l'utilisateur clique sur la croix.
#
#   Voici ses VI :
#
#   @save : recupere la sauvegarde de tous les profils present sur la machine actuelle
#   @quit : permet de communiquer à FenetreMenu si la fenetre a été fermé ou pas
#   @popUpProfil : représente la fenêtre qui va acceuillir l'interface
#   @profil : stock le profil selectionné par l'utilisateur, est récupéré ensuite par FenetreMenu


class FenetreProfil

    attr_accessor :save,:profil, :quit

    ##
    # initialize :
    #   Cette méthode est le constructeur de la classe FenetreProfil, il permet d'initialiser ses VI et de récupérer
    #   la sauvegarde des profils existant sur la machine actuelle.
    def initialize
        @save = SauvegardeProfil.new
        @quit = false
        @popUpProfil = Window.new()
        @profil = nil
    end

    ##
    # setMargin :
    #   ???
    #
    def setmargin(obj, top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end


    ##
    # afficheToi :
    #   Cette méthode permet de creer et d'afficher l'interface du choix de profils, elle creer
    #   autant de bouton qu'il y a de profils, ce qui permet une extension dynamique de la fenêtre.
    #   Elle permet aussi de gerer la suppresion des profils ou la création.
    def afficheToi
        @popUpProfil = Window.new()
        @save = SauvegardeProfil.new
        @popUpProfil.set_title("Choix profil")
        @popUpProfil.border_width=10
        @popUpProfil.set_resizable(false)
        @popUpProfil.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
        @popUpProfil.signal_connect('destroy') {destruction}
        @popUpProfil.add(laFenetrePrincipale=Gtk::Box.new(:vertical, (@save.nbProfil + 1) ) )

        laFenetrePrincipale.add(haut=Gtk::Box.new(:horizontal, 2))

        zoneText = Entry.new
        haut.add(setmargin(zoneText, 0, 15, 0, 0))

        imageValider = Gtk::Image.new :file => "Image/valider.png"
        boutonValider = Button.new()
        boutonValider.image = imageValider
        boutonValider.set_width_request(60)
        haut.add(setmargin(boutonValider, 0, 15, 5, 0))

        if @save.nbProfil != 0
            @save.listeProfil.each do |key, value|
                ligneProfil=Gtk::Box.new(:horizontal, 3) # Box pour l'image du profil, son nom et le bouton supprimer
  
                pixbuf = GdkPixbuf::Pixbuf.new(:file => key.imageJoueur)
                pixbuf = pixbuf.scale_simple(20, 20, Gdk::Pixbuf::INTERP_BILINEAR)
                imageProfil = Gtk::Image.new
                imageProfil.set_from_pixbuf(pixbuf)
                ligneProfil.add(setmargin(imageProfil, 0, 0, 0, 5))

                boutonProfil = Button.new(:label => key.pseudo)
                boutonProfil.set_width_request(140)
                ligneProfil.add(boutonProfil)

                imageSupprimer = Gtk::Image.new :file => "Image/iconeMenu/trash.png"
                boutonSupprimer = Button.new()
                boutonSupprimer.image = imageSupprimer
                boutonSupprimer.set_width_request(60)
                ligneProfil.add(setmargin(boutonSupprimer, 0, 0, 5, 0))

                laFenetrePrincipale.add(ligneProfil)
                
                boutonProfil.signal_connect('clicked'){
                    @profil = @save.chargerProfil(key.pseudo)
                    if(!File.exist?("Sauvegarde/SauvegardeGrille/listeGrille#{@profil.pseudo}.dump"))
                        @profil.listePartieCommence = Array.new
                    else  
                        @profil.listePartieCommence = Marshal.load(File.binread("Sauvegarde/SauvegardeGrille/listeGrille#{@profil.pseudo}.dump"))
                    end
                    event(@popUpProfil)
                }

                boutonSupprimer.signal_connect('clicked'){
                    d = Gtk::MessageDialog.new(@popUpProfil,
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


        boutonValider.signal_connect('clicked') {
            pseudo = zoneText.text.to_s
            if pseudo.length != 0
                @profil = Profil.new(pseudo)
                if @save.ajoutProfil(profil) != -1
                    @profil = @save.chargerProfil(pseudo)
                    event(@popUpProfil)
                else
                    d = Gtk::MessageDialog.new(@popUpProfil,
                    Gtk::Dialog::DESTROY_WITH_PARENT,
                    Gtk::MessageDialog::WARNING,
                    Gtk::MessageDialog::BUTTONS_CLOSE,
                    "Le pseudo #{pseudo} existe déjà...")

                    d.run
                    d.destroy
                end
            end
        }

        @popUpProfil.show_all

        Gtk.main           
    end

    ##
    # event :
    #   Cette méthode permet de cacher la fenetre lorsque l'utilisateur a choisi/créé un profil
    #   @param popUpProfil represente la fenetre à cacher.
    def event(popUpProfil)
        popUpProfil.hide
        Gtk.main_quit  
    end

    ##
    # destruction :
    #   Cette méthode permet de supprimer la fenetre si l'utilisateur la ferme. Elle met donc le boolean "@quit" à jour.
    def destruction()
        @quit = true
        Gtk.main_quit
    end

end