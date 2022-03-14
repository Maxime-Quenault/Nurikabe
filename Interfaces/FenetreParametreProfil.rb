load "Interfaces/FenetreProfil.rb"
load "Interfaces/Fenetre.rb"

class FenetreParametreProfil < Fenetre

    attr_accessor :object

    def initialize(menuParent)

        self.initialiseToi

        @builderProfil = Gtk::Builder.new(:file => 'glade/gestion_profil.glade')

        @object = @builderProfil.get_object("menuParam")

        @btnParametre = @builderProfil.get_object("button_jeu")
        @btnRetour = @builderProfil.get_object("button_retour")
        @btnChangerProfils = @builderProfil.get_object("btn_changer_profil")

        self.gestionSignaux

        @menuParent = menuParent
        print @profil
    end

    def gestionSignaux
        @btnChangerProfils.signal_connect( "clicked" ) {
            print "\nTu as clique sur profil"
            @interfaceProfil.afficheToi
        }

        @btnRetour.signal_connect( "clicked" ) {
            self.changerInterface(@menuParent, "Menu")
        }

    end

end