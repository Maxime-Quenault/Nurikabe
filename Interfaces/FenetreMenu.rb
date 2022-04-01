require 'gtk3'

load "Interfaces/FenetreProfil.rb"
load "Interfaces/FenetreLibre.rb"
load "Interfaces/FenetreParametre.rb"
load "Interfaces/FenetreAPropos.rb"
load "Interfaces/ContreLaMontre/FenetreContreMontre.rb"
load "Interfaces/Survie/FenetreSurvie.rb"
load "Interfaces/Fenetre.rb"
load "Sauvegarde/Profil.rb"
load "Interfaces/AffichageAventure.rb"
load "Interfaces/FenetreRegle.rb"
load "Interfaces/FenetreTechnique.rb"

##
# 	@author Quenault Maxime
#
#	Cette classe va gerer l'interface du menu. Pour cela elle récupère le fichier glade associé
#	et initialise toutes ses variables d'instance avec les objets du fichier glade.
#
#	Voici les methodes de la classe FenetreMenu :
#
#	- initialize : cette methode est le constructeur, elle recupere le fichier glade et initialise ses VI.
#	- getObjet : permet de renvoyer sont interface à tous ceux qui la demande.
#	- gestionSignaux : permet d'attribuer des actions à tous les objets de l'interface récupéré dans le constructeur.
#
#	Voici ses VI :
#
#	@builder : represente le fichier glade
#	@object : represente l'interface de la classe
#
#   @interfaceAPropos : represente l'interface A propos
#   @interfaceLibre : represente l'interface du mode libre
#   @interfaceAventure : represente l'interface du mode aventure
#   @interfaceSurvie : represente l'interface du mode survie
#   @interfaceContreMontre : represente l'interface du mode contre la montre
#   @interfaceProfil : represente l'interface de la selection du profil
#   @interfaceParametre : represente l'interface des parametres
#
#   @quit : permet de savoir si oui ou non l'utilisateur a choisi un profil ou non
#   @profil : represente le profil selectionné
#
#   @btn_libre : represente l'objet bouton mode libre
#   @btn_survie : represente l'objet bouton mode survie
#   @btn_contre_montre : represente l'objet bouton mode contre la montre
#   @btn_aventure : represente l'objet bouton mode aventure
#   @btn_regle : represente l'objet bouton tuto
#   @btn_propos : represente l'objet bouton a propos
#   @btn_parametre : represente l'objet bouton parametre
#	


class FenetreMenu < Fenetre

    attr_accessor :profil, :quit, :object

    ##
    # initialize :
    #   Cette methode est le constructeur, il permet de recuperer le fichier glade associé au menu et
    #   il initialise toutes les VI de la classe. Il vérifie egalement si le joueur à bien séléctionné un profil, 
    #   pour cela on récupére un boolean de la classe FenetreProfil et on agit en conséquance.
    def initialize

        self.initialiseToi

        @builder = Gtk::Builder.new(:file => 'glade/menu.glade')
        @object = @builder.get_object("menu")      


        #On récupere le profil séléctionné par le joueur.
        @interfaceProfil = FenetreProfil.new
        @interfaceProfil.afficheToi
        @@profilActuel = @interfaceProfil.profil


        #On initialise toutes les interfaces connue par le menu (interfaces filles).
        @interfaceAPropos = FenetreAPropos.new(@object)
        @interfaceLibre = FenetreLibre.new(@object)
        @interfaceAventure = AffichageAventure.new(@object)
        @interfaceSurvie = FenetreSurvie.new(@object)
        @interfaceContreMontre = FenetreContreMontre.new(@object)
        @interfaceParametre = FenetreParametre.new(@object)
        @interfaceRegle = FenetreRegle.new(@object)
        @interfaceTechnique = FenetreTechnique.new(@object)

        

        #Recuperation des variables bouton
        @btn_libre = @builder.get_object("btn_libre")
        @btn_survie = @builder.get_object("btn_survie")
        @btn_contre_montre = @builder.get_object("btn_contre_montre")
        @btn_aventure = @builder.get_object("btn_aventure")
        @btn_regle = @builder.get_object("btn_regle")
        @btn_technique = @builder.get_object("btn_technique")
        @btn_propos = @builder.get_object("btn_propos")
        @btn_parametre = @builder.get_object("btn_parametre")

        #Ici on vérifie si le joueur souhaite quitter le jeu en etant sur la fenêtre du choix de profil.
        @quit = false
        if @interfaceProfil.quit
            @quit = true
        end

        setStyle(@@profilActuel)
        ajustementsCSS()

        self.gestionSignaux

    end

    ##
	# getObjet :
	# 	Cette methode permet d'envoyer sont objet (interface) a l'objet qui le demande.
	#
	# @return object qui represente l'interface de la fenetre du mode libre.
	def getObjet
		return @object
	end

    ##
	# gestionSignaux :
	#	Cette methode permet d'assigner des actions à chaques boutons récupérés dans le fichier galde.
    def gestionSignaux
        @btn_libre.signal_connect('clicked') {
            self.changerInterface(@interfaceLibre.getObjet, "Mode Libre")
        }

        @btn_survie.signal_connect('clicked') {
            self.changerInterface(@interfaceSurvie.getObjet, "Mode Survie")
        }

        @btn_contre_montre.signal_connect('clicked') {
            self.changerInterface(@interfaceContreMontre.object, "Contre la montre")
        }

        @btn_aventure.signal_connect('clicked') {
            self.changerInterface(@interfaceAventure.getObject, "Aventure")
        }

        @btn_regle.signal_connect('clicked') {
            self.changerInterface(@interfaceRegle.object, "Règles")
        }
        @btn_technique.signal_connect('clicked') {
            self.changerInterface(@interfaceTechnique.object, "Techniques de résolution")
        }

        @btn_propos.signal_connect('clicked') {
            self.changerInterface(@interfaceAPropos.object, "A propos")
        }

        @btn_parametre.signal_connect('clicked') {
            self.changerInterface(@interfaceParametre.object, "Parametre")
        }
    end
end