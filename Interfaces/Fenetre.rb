#!/usr/bin/ruby
require 'gtk3'
load 'Partie/Partie.rb'


##
#   @author Quenault Maxime
#   
#   Cette classe permet de creer une fenetre. Elle gere egalement les changements d'interface.
#   seulement les classes filles peuvent creer la classe Fenetre, la methode new est privé.
#   
#   Voici les methodes de la classe Fenetre :
#
#   - changerInterface : gere le changement d'interface sur la fenetre.
#   - initialiseToi : permet d'initialiser une fenetre 1 seul fois, pour cela nous utilison le pattern SINGLETON.
#   - set_sousTitre : permet de mettre à jour le sous-titre de la fenetre.
#   - affichage : permet d'ajouter la nouvelle interface à la fenetre.
#   - deleteChildren : permet de supprimer tous les objets fils de la fenetre sauf la headerbar.
#   - remove : permet de supprimer un objet de la fenetre.
#   - quitter : permet de quitter le programme "proprement".
#
#   Voici ses VI : 
#
#   @header : elle represente la haute bar de notre fenetre.
#   @css    : gère la mise en page et la présentation de l'interface
#
#
#   Voici ses VC :
#   
#   @@window        : elle represente notre fenetre, elle est initialisé qu'une seul fois.
#   @@partie        : représentre la partie courante
#   @@profilActuel  : contient le profil actuel sélectionné par le joueur


$LARGEUR_FENETRE = 745
$HAUTEUR_FENETRE = 850

class Fenetre

    @@window = nil
    @@partie = nil
    @@profilActuel = nil
    @@numGrille = nil

    #private_method new

    ##
    # changerInterface :
    #   Cette classe gère le changement d'interface, pour cela elle commence par supprimer
    #   tous les objets fils de la fenetre et ensuite fait appel la methode "Affichage".
    #   Cette methode est public car elle est appelé par la classe "Jeu.rb"
    #
    # @param uneInterface represente la nouvelle interface qu'il va falloire afficher.
    # @param sousTitre represente le nouveau sous-titre qu'il faudra ajouter.
    def changerInterface(uneInterface, sousTitre)
        self.deleteChildren()
        self.affichage(uneInterface, sousTitre)
    end

    # TOUTES LES METHODES QUI SUIVENT SONT PRIVEE !

    private

    
    ##
    # initialize :
    #   Cette methode est le constructeur de notre classe, il initilise notre
    #   fenetre avec les bonnes dimenssion et les bons parametres. Il fait de
    #   même avec la headerbar.
    def initialize

        Gtk.init
        
        @@window = Gtk::Window.new()

        #Option de la fenetre
        @@window.set_default_size($LARGEUR_FENETRE , $HAUTEUR_FENETRE)
        @@window.set_width_request($LARGEUR_FENETRE)
        @@window.set_height_request($HAUTEUR_FENETRE)
        @@window.set_resizable(false)
        @@window.signal_connect("destroy") { quitter }
        @@window.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)

        #Creation header
        @header = Gtk::HeaderBar.new
        @header.show_close_button = true
        @header.name = "headerbar"
        @header.title = "Nurikabe"
        @header.subtitle = "-"
        @@window.titlebar = @header

        #CSS
        @@css = Gtk::CssProvider.new
        @@css.load(path: "Interfaces/style.css")
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, @@css, Gtk::StyleProvider::PRIORITY_APPLICATION)

        @@cssDark = Gtk::CssProvider.new
        @@cssDark.load(path: "Interfaces/style_dark.css")

        #sauvegarde
        @save = SauvegardeProfil.new

    end


    ##
    # initialiseToi :
    #   Cette methode permet de gerer l'initialisation de notre fenetre. Pour vérifier que notre fenetre est initialisé
    #   qu'une seul fois on effectue une vérification avant de faire appel au constructeur. C'est cette méthode qui est appelé
    #   par toutes les autres classes.
    def initialiseToi
        if @@window == nil
            Fenetre.new()
        else
            puts "Fenêtre déjà initialisée"
        end
    end


    ##
    # set_sousTitre :
    #   Cette methode permet de mettre à jour les sous-titre de la fenetre.
    #
    # @param subtitle represente le nouveau sous-titre de la fenetre.
    def set_sousTitre(subtitle)
        @@window.titlebar.subtitle  = subtitle
    end

    def get_sousTitre()
        return @@window.titlebar.subtitle
    end


    ##
    # affichage :
    #   Cette methode permet d'afficher la nouvelle interface. Elle ajoute le nouvelle objet et
    #   met à jour le nouveau sous-titre.
    #
    # @param unObjet represente la nouvelle interface.
    # @unSousTitre represente le nouveau sous-titre.
    def affichage(unObjet, unSousTitre)
        @@window.add(unObjet)
        self.set_sousTitre(unSousTitre)
        @@window.show_all     
    end


    ##
    # deleteChildren :
    #   cette classe permet de supprimer tous les objets de notre fenetre, sauf la headerbar.
    def deleteChildren()
        i = 0
        while @@window.children.length > 1
            if( @@window.children[i] == @@window.titlebar )
                i += 1
            end
            @@window.remove( @@window.children[i] )
        end
    end


    ##
    # remove :
    #   Cette methode permet de supprimer un objet de la fenetre.
    #
    # @param unObjet represente l'objet à supprimer de la fenetre.
    def remove(unObjet)
        @@window.remove(unObjet)
    end


    ##
    # quitter :
    #   Supprime tous les élements de la fenetre avant de quitter le programme.
    def quitter
        if @@partie!=nil
            @@profilActuel.ajouterPartie(@@partie)
        end
        self.deleteChildren
        self.remove(@header)
        Gtk.main_quit
    end

    ##
    # creerPartie :
    #   Creer et affecte une partie à la variable de classe partie avec la grille passée en paramètre
    def creerPartie(grille)
        @@partie = Partie.creeToi(grille)
    end

    def getNumGrille
        @@numGrille
    end

    def setNumGrille(unNum)
        @@numGrille = unNum
    end

    ##
    # setStyle :
    #   Prend en paramètre un profil et change le style de la fenêtre en fonction du thème choisi par l'utilisateur
    def setStyle(profil)
        case (profil.parametre.themeSombre)
        when false 
           Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, @@css, Gtk::StyleProvider::PRIORITY_APPLICATION)
        when true 
            Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, @@cssDark, Gtk::StyleProvider::PRIORITY_APPLICATION)
        end 
    end 

    ##
    # ajustementCSS :
    # Ajuste la couleur des cases de la grille pour correspondre aux paramètre du profil actuel
    def ajustementsCSS()
        classList = Array.new
        File.delete("Interfaces/style_temp.css") if File.exist?("Interfaces/style_temp.css")
        cssTemp = File.new("Interfaces/style_temp.css", "w")
        cssTemp.puts("#case_noir { background: #{@@profilActuel.parametre.couleur}; } #case_point, #case_chiffre { color : #{@@profilActuel.parametre.couleur}; }")
        cssTemp.close
        cssTemp = Gtk::CssProvider.new
        cssTemp.load(path: "Interfaces/style_temp.css")
        Gtk::StyleContext.add_provider_for_screen(Gdk::Screen.default, cssTemp, Gtk::StyleProvider::PRIORITY_APPLICATION)
    end

end