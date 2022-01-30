require "yaml.rb"
load "Profil.rb"

require 'gtk3'
include Gtk

class SauvegardeProfil


    attr_accessor :listeProfil, :nbProfil
    
    def initialize()
        if(!File.exist?("./SauvegardeProfil/listeProfil.yml"))
            @listeProfil = Array.new
            @nbProfil = 0
        else  
            @listeProfil = YAML.load(File.read("./SauvegardeProfil/listeProfil.yml"))
            @nbProfil = self.getNbProfil
        end
    end

    def ajoutProfil(unProfil)
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                return -1
            end
        end
        print "\n\nunProfil : #{unProfil}"
        @listeProfil.push(unProfil)    
        File.open("./SauvegardeProfil/listeProfil.yml", "w") { |file| file.write(listeProfil.to_yaml) }
        @listeProfil = YAML.load(File.read("./SauvegardeProfil/listeProfil.yml"))
        @nbProfil = @nbProfil + 1
        return 1
    end

    def suppAllProfil
        @listeProfil.each do |key, value|
            supprimerProfil(key)
        end
        print @listeProfil
    end

    def supprimerProfil(unProfil)
        @listeProfil.each do |key, value|
            if(key.pseudo == unProfil.pseudo)
                @listeProfil.delete(key)    
                File.open("./SauvegardeProfil/listeProfil.yml", "w") { |file| file.write(listeProfil.to_yaml) }
                @listeProfil = YAML.load(File.read("./SauvegardeProfil/listeProfil.yml"))
                @nbProfil = @nbProfil - 1
            end
        end
        
    end

    def getNbProfil
        nombre = 0
        @listeProfil.each do |key, value|
            nombre = nombre + 1
        end
        nombre
    end

    def chargerProfil(unPseudo)
        @listeProfil.each do |key, value|
            if(key.pseudo == unPseudo)
                return key
            end
        end
    end






    #
    # cette version de "afficherSauvegarde" est fonctionnel
    #
    def afficherSauvegardeV1()


        ##################################
        ## FONCTION BASIQUE DE CREATION ##

        #Ne pas oublier cela sinon ca plante grave
        Gtk.init 
        monApplication = Window.new
        monApplication.set_title("Choix profil")
        monApplication.border_width=5
        # On ne peut pas redimensionner
        monApplication.set_resizable(false)
        # L'application est toujours centrée
        monApplication.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
        # Quand l'UI est détruite il faut quitter
        monApplication.signal_connect('destroy') {self.destruction}
        ##################################




        ####################################
        ## CREATION DES BOX DE LA FENÊTRE ##
        monApplication.add(laFenetrePrincipale=Gtk::Box.new(:vertical, (self.nbProfil + 1) ) )
        laFenetrePrincipale.add(haut=Gtk::Box.new(:horizontal, 2 ) )
        ####################################





        ###################################
        ## CREATION BOUTON + ZONE SAISIE ##

        zoneText = Entry.new
        haut.add(zoneText)

        boutonValider = Button.new(:label => "Valider")
        haut.add(boutonValider)

        if self.nbProfil != 0
            @listeProfil.each do |key, value|
                boutonProfil = Button.new(:label => key.pseudo)
                laFenetrePrincipale.add(boutonProfil)
                boutonProfil.signal_connect('clicked'){
                    profil = self.chargerProfil(key.pseudo)
                    print "Tu as selectionné le profil \"#{profil.pseudo}\""
                    destruction
                }
            end
        end 
        ###################################



        ############################################
        ## GESTION SIGNAL DE CLIQUE SUR LE BOUTON ##

        boutonValider.signal_connect('clicked') {
            pseudo = zoneText.text.to_s
            if pseudo.length != 0
                profil = Profil.new(pseudo)
                if self.ajoutProfil(profil) == -1
                    profil = chargerProfil(pseudo)
                end
                print "Tu as selectionné le profil \"#{profil.pseudo}\""
                destruction
            end
        }
        ############################################

        
        #############################
        ## AFFICHAGE DE LA FENETRE ##
        monApplication.show_all
        #############################



        Gtk.main           
    end






    #
    # Cette version 2 utilise un model glade, pour cela il faut creer un builder qui va recuperer le fichier, 
    # ensuite on recupere dans des variable les objets creer sur le model glade (les noms c'est moi qui les ais
    # mis lors de la création de l'objet sur glade). Tout fonctionne sauf le "show_all" et actuellement il est 00h42
    # et ça fait presque 40 min que je cherche comment faire pour afficher un builder à l'ecran.
    #

    def afficherSauvegardeV2()
        #Ne pas oublier cela sinon ca plante grave
        Gtk.init 

        monBuilder = Gtk::Builder.new

        monBuilder.add_from_file("glade/choixProfil.glade") 
        monBuilder.connect_signals {|handler| method(handler) }

        bouton = monBuilder.get_object("bouton")
        zoneText = monBuilder.get_object("zoneText")
        fenetre = monBuilder.get_object("maFenetre")

        bouton.signal_connect('clicked') {
            text = zoneText.text.to_s
            if text.length != 0
                profil = Profil.new(text)
                self.ajoutProfil(profil)
                destruction
            end
        }

        #Affichage de la fenêtre
        #monBuilder.show#faire en sorte d'afficher la fenetre 
        fenetre.show_all
        Gtk.main           
    end

    def destruction
        Gtk.main_quit
        return
    end
end

##  TEST UNITAIRE  ##

uneSave = SauvegardeProfil.new()

#uneSave.suppAllProfil


uneSave.afficherSauvegardeV1
print "\n"



#profil2 = uneSave.chargerProfil("Leo")
#uneSave.supprimerProfil(profil2)