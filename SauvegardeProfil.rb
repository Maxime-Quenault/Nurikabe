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

    def modifierPseudo(unProfil)
        @listeProfil.each do |key, value|
            if key.pseudo == unProfil.pseudo
                index = @listeProfil.index(key) 
                @listeProfil[index].pseudo = "Leo"   
                File.open("./SauvegardeProfil/listeProfil.yml", "w") { |file| file.write(listeProfil.to_yaml) }
                @listeProfil = YAML.load(File.read("./SauvegardeProfil/listeProfil.yml"))                
            end
        end
    end






    #
    # cette version de "afficherSauvegarde" est fonctionnel
    #
    def afficherSauvegarde

        def destruction
            Gtk.main_quit
            return
        end


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
        monApplication.signal_connect('destroy') {destruction}
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

end

##  TEST UNITAIRE  ##

uneSave = SauvegardeProfil.new()

#uneSave.suppAllProfil


uneSave.afficherSauvegarde
#print "\n"



#profil2 = uneSave.chargerProfil("LeoModifPseudo")
#uneSave.supprimerProfil(profil2)