#load 'Sauvegarde/Profil.rb'
load "Interfaces/FenetreProfil.rb"
load "Interfaces/Fenetre.rb"
load "Interfaces/FenetreParametreProfil.rb"
#load "Interfaces/FenetreGestionProfil.rb"

=begin
        La classe AffichageParamètre :::
            - peut afficher l'interface qui va gérer la langue
            - peut afficher l'interface qui va gérer les couleurs
            - peut afficher l'interface qui va gérer les effets sonores
            - peut afficher l'intterface qui va gérer les profils

        Les VI de cette classe sont :::
            - @profil ==> Le profil associé aux paramètres lorsque l'application est lancée
=end

class FenetreParametre < Fenetre

    attr_accessor :object

    def initialize(menuParent)

        self.initialiseToi

        @builderJeu = Gtk::Builder.new(:file => 'glade/settingsNurikabe.glade')

        @object = @builderJeu.get_object("menuParam")

        @interfaceProfil = FenetreProfil.new
        @interfaceParametreProfil = FenetreParametreProfil.new(menuParent)

        @langue = @builderJeu.get_object("cbt_langue")

        @btnJeu = @builderJeu.get_object("button_jeu")
        @btnRetour = @builderJeu.get_object("button_retour")
        @btnProfils = @builderJeu.get_object("btn_gestion_profil")

        @switchTheme = @builderJeu.get_object("switch_theme")
        @switchAudio = @builderJeu.get_object("switch_audio")

        self.gestionSignaux

        @menuParent = menuParent
    end


    def gestionSignaux
        @btnProfils.signal_connect( "clicked" ) { 
            print "\nTu as clique sur profil"
            self.changerInterface(@interfaceParametreProfil.object, "Paramètres")
        }

        @btnRetour.signal_connect( "clicked" ) {
            self.changerInterface(@menuParent, "Menu")
        }

    end

end

# class FenetreParametre < Fenetre

#     attr_accessor :object

#     def initialize(menuParent)
#         self.initialiseToi
#         @builder = Gtk::Builder.new(:file => 'glade/settingsNurikabe.glade')
#         @object = @builder.get_object("menuParam")

#         @interfaceGestionProfil = FenetreGestionProfil.new(@object)

#         @langue = @builder.get_object("cbt_langue")

#         @btnJeu = @builder.get_object("button_jeu")
#         @btnRetour = @builder.get_object("button_retour")
#         @btnGestionProfil = @builder.get_object("btn_gestion_profil")

#         @switchTheme = @builder.get_object("switch_theme")
#         @switchAudio = @builder.get_object("switch_audio")

#         self.gestionSignaux

#         @menuParent = menuParent
#     end


#     def gestionSignaux
#         @btnGestionProfil.signal_connect( "clicked" ) { 
#             print "\nTu as clique sur profil"
#             self.changerInterface(@interfaceGestionProfil, "gestion")
#         }

#         @btnRetour.signal_connect( "clicked" ) {
#             self.changerInterface(@menuParent, "Menu")
#         }
#     end

# end