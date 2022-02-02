#load "Profil.rb"
#load "../Parametre/Parametre.rb"

require 'gtk3'
include Gtk

class SauvegardeProfil


    attr_accessor :listeProfil, :nbProfil
    
    def initialize()
        if(!File.exist?("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
            @listeProfil = Array.new
            @nbProfil = 0
        else  
            @listeProfil = Marshal.load(File.binread("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
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
        File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
        @listeProfil = Marshal.load(File.binread("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
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
                File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
                @listeProfil = Marshal.load(File.binread("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
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

    def modifierPseudo(unPseudo, profilActuel)
        @listeProfil.each do |key, value|
            if(key.pseudo == unPseudo)
                return false
            end
        end
        @listeProfil.each do |key, value|
            if key.pseudo == profilActuel.pseudo 
                key.pseudo = unPseudo                   
            end
            File.open("Sauvegarde/SauvegardeProfil/listeProfil.dump", "wb") { |file| file.write(Marshal.dump(@listeProfil)) }
            @listeProfil = Marshal.load(File.binread("Sauvegarde/SauvegardeProfil/listeProfil.dump"))
        end
        return true
    end






    #
    # cette version de "afficherSauvegarde" est fonctionnel
    #
    def afficherSauvegarde

        def destruction(profil)
            Gtk.main_quit
            return profil
        end


        ##################################
        ## FONCTION BASIQUE DE CREATION ##
        #Gtk.init
        #Ne pas oublier cela sinon ca plante grave
        #Gtk.init 
        monApplication = Window.new
        monApplication.set_title("Choix profil")
        monApplication.border_width=5
        # On ne peut pas redimensionner
        monApplication.set_resizable(false)
        # L'application est toujours centrée
        monApplication.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
        # Quand l'UI est détruite il faut quitter
        monApplication.signal_connect('destroy') {Gtk.main_quit}
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
                    #print "Tu as selectionné le profil \"#{profil.pseudo}\""
                    destruction(profil)
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
                #print "Tu as selectionné le profil \"#{profil.pseudo}\""
                destruction(profil)
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

#uneSave = SauvegardeProfil.new()
# profil1 = Profil.new("Léo")
# uneSave.ajoutProfil(profil1)
# profil2 = Profil.new("Maxime")
# uneSave.ajoutProfil(profil2)

# profil = uneSave.chargerProfil("Léo")

# uneSave.modifierPseudo("Léo", profil)
#unProfil = uneSave.afficherSauvegarde