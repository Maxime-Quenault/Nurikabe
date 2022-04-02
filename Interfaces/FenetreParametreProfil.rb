load "Interfaces/FenetreProfil.rb"
load "Interfaces/Fenetre.rb"
load "Interfaces/FenetreChoixAvatar.rb"
load "Sauvegarde/SauvegardeProfil.rb"

##
#   Cette classe permet de gerer l'interface des parametre dans l'onglet "profil"
#
#   Voici ses méthodes :
#
#   - gestionSignaux : permet d'attribuer des actions à tous les objets de l'interface récupéré dans le constructeur. 
#
#   Voici ses VI : 
#
#   - @save : permet de stocker une sauvegarde qui contient la liste des profils
#   - @builderProfil : represente l'objet contenant l'interface
#   - @interfaceAvatar : represente l'interface à afficher pour le choix d'avatar
#   - @object : represente l'interface à afficher
#   - @objectImage : represente l'avatar du profil actuel
#   - @objectPseudo : represente le label contenant le pseudo de l'utilisateur
#   - @btn_changer_image : bouton de l'interface
#   - @btnProfil : bouton de l'interface
#   - @btnParametreJeu : bouton de l'interface
#   - @btnRetour : bouton de l'interface
#   - @btnChangerProfils : bouton de l'interface
#   - @menuParametreJeu : represente l'interface qui devra être afficher lors d'un clique sur le bouton "@btnParametreJeu"
#   - @menuParent : represente l'interface paretn qui devra être afficher lors d'un clique sur le bouton retour de l'interface


class FenetreParametreProfil < Fenetre

    attr_accessor :object, :save

    def initialize(menuParent, menuParametreJeu, save)

        self.initialiseToi

        @save = save

        @builderProfil = Gtk::Builder.new(:file => 'glade/gestion_profil.glade')

        @interfaceAvatar = FenetreChoixAvatar.new(@@profilActuel.imageJoueur)

        @object = @builderProfil.get_object("menuParam")

        @objectImage = @builderProfil.get_object("image_profil")
        pixbuf = GdkPixbuf::Pixbuf.new(:file => @@profilActuel.imageJoueur)
        pixbuf = pixbuf.scale_simple(100, 100, Gdk::Pixbuf::INTERP_BILINEAR)
        @objectImage.set_from_pixbuf(pixbuf)

        @objectPseudo = @builderProfil.get_object("pseudo_profil")
        @objectPseudo.set_label(@@profilActuel.pseudo)

        @btn_changer_image = @builderProfil.get_object("change_avatar")

        @btnProfil = @builderProfil.get_object("btn_gestion_profil")
        @btnParametreJeu = @builderProfil.get_object("button_jeu")
        @btnRetour = @builderProfil.get_object("button_retour")
        @btnChangerProfils = @builderProfil.get_object("btn_changer_profil")

        @btnParametreJeu.name = "btn_jeu"
        @btnRetour.name = "btn_retour"
        @btnProfil.name = "btn_profil"

        self.gestionSignaux

        @menuParametreJeu = menuParametreJeu
        @menuParent = menuParent
    end

    ##
	# gestionSignaux :
	#	Cette methode permet d'assigner des actions à chaques boutons récupérés dans le fichier galde.
    def gestionSignaux
        @btnChangerProfils.signal_connect( "clicked" ) {
            @interfaceProfil = FenetreProfil.new
            @interfaceProfil.afficheToi
            @save = SauvegardeProfil.new
            if(@interfaceProfil.profil != nil)
                @@profilActuel = @interfaceProfil.profil
            end
            @@profilActuel = @save.chargerProfil(@@profilActuel.pseudo)
            pixbuf = GdkPixbuf::Pixbuf.new(:file => @@profilActuel.imageJoueur)
            pixbuf = pixbuf.scale_simple(100, 100, Gdk::Pixbuf::INTERP_BILINEAR)
            @objectImage.set_from_pixbuf(pixbuf)
            @objectPseudo.set_label(@@profilActuel.pseudo)  
        }

        @btnRetour.signal_connect( "clicked" ) {
            self.changerInterface(@menuParent, "Menu")
        }

        @btnParametreJeu.signal_connect( "clicked" ) {
            self.changerInterface(@menuParametreJeu, "Paramètres")
        }

        @btn_changer_image.signal_connect( "clicked" ) {
            # Permet de modifier l'avatar sur le jeu directement et dans la save
            @interfaceAvatar.afficheToi
            avatar = @interfaceAvatar.choixAvatar
            if(avatar.empty? || avatar.nil?)
                avatar = @@profilActuel.imageJoueur
            end
            @save.modifierAvatar(avatar, @@profilActuel)
            @@profilActuel = @save.chargerProfil(@@profilActuel.pseudo)
            pixbuf = GdkPixbuf::Pixbuf.new(:file => @@profilActuel.imageJoueur)
            pixbuf = pixbuf.scale_simple(100, 100, Gdk::Pixbuf::INTERP_BILINEAR)
            @objectImage.set_from_pixbuf(pixbuf)
        }

    end

end
