require "yaml.rb"
require 'gtk3'
include Gtk
load "Score.rb"
load "SauvegardeProfil.rb"

class SauvegardeClassementSurvie

    attr_accessor :tabScore, :nbScoreOccupe

	def initialize()
        if(!File.exist?("./SauvegardeScore/scoreSurvie.yml"))
            @tabScore = Array.new(10)
            @nbScoreOccupe = 0; 
            File.open("./SauvegardeScore/scoreSurvie.yml", "w") { |file| file.write(tabScore.to_yaml) }
        else
            @tabScore = YAML.load(File.read("./SauvegardeScore/scoreSurvie.yml"))
            @nbScoreOccupe = self.getNbScoreOccupe
        end
    end


    #
    # ici quand j'ajoute un score je trie le tableau des scores en même temps
    # ce qui permet de toujours garder un tableau de score de 10 de longueur et des scores toujours triés
    #
    def ajoutScore(unScore)
        tabTampon = Array.new(10)
        i = 0
        y = 0
        flagNil = 0
        flagAjoute = 0
        totalTempsScoreAAjouter = unScore.getHeures() * 60 + unScore.getMinutes() + unScore.getSecondes()/60.to_f;
        totalTempsScoreTableau = 0;
    
        # Parcours tous les scores et insert le score en fonction des autres
        while i < nbScoreOccupe && flagAjoute == 0
            totalTempsScoreTableau = @tabScore[i].getHeures() * 60 + @tabScore[i].getMinutes() + @tabScore[i].getSecondes()/60.to_f
        	if totalTempsScoreAAjouter.to_f < totalTempsScoreTableau.to_f
        		@tabScore.insert(i, unScore)
                if self.getNbScoreOccupe() > 10 # Il vérifie le nombre de score occupé, si c'est > 10, il faut alors supprimer le 11ème qui est le plus nul
                    @tabScore.delete_at(10)
                end
        		flagAjoute = 1
        	else
                i += 1
        	end            
        end
        
        # Ajoute le score si il reste de la place (puisque c'est le moins bon)
        if flagAjoute == 0 && i < 10
            @tabScore.insert(i, unScore)
        end
        File.open("./SauvegardeScore/scoreSurvie.yml", "w") { |file| file.write(@tabScore.to_yaml) }
    end

    def getNbScoreOccupe
        nombre = 0
        @tabScore.each do |key, value|
            if key != nil
                nombre = nombre + 1
            end
        end
        nombre
    end

    def afficheToi2
        Gtk.init

        def destruction
            Gtk.main_quit
            return
        end

        monBuilder = Gtk::Builder.new
        monBuilder.add_from_file("glade/survie_nouvelle_partie.glade") 
        #monBuilder.connect_signals {|handler| method(handler) }

        #recuperation des variables

        fenetre2 = monBuilder.get_object("fenetre2")

        fenetre2.signal_connect('destroy') {destruction}

        pseudo1 = monBuilder.get_object("pseudo1")
        pseudo2 = monBuilder.get_object("pseudo2")
        pseudo3 = monBuilder.get_object("pseudo3")
        pseudo4 = monBuilder.get_object("pseudo4")
        pseudo5 = monBuilder.get_object("pseudo5")
        pseudo6 = monBuilder.get_object("pseudo6")
        pseudo7 = monBuilder.get_object("pseudo7")
        pseudo8 = monBuilder.get_object("pseudo8")
        pseudo9 = monBuilder.get_object("pseudo9")
        pseudo10 = monBuilder.get_object("pseudo10")

        temps1 = monBuilder.get_object("temps1")
        temps2 = monBuilder.get_object("temps2")
        temps3 = monBuilder.get_object("temps3")
        temps4 = monBuilder.get_object("temps4")
        temps5 = monBuilder.get_object("temps5")
        temps6 = monBuilder.get_object("temps6")
        temps7 = monBuilder.get_object("temps7")
        temps8 = monBuilder.get_object("temps8")
        temps9 = monBuilder.get_object("temps9")
        temps10 = monBuilder.get_object("temps10")

        if @tabScore[0] != nil
        	pseudo1.set_text(@tabScore[0].profil.pseudo)
        	temps1.set_text("#{@tabScore[0].getHeures}h#{@tabScore[0].getMinutes}m#{@tabScore[0].getSecondes}s")
        else
        	pseudo1.set_text("-")
        	temps1.set_text("-:-:-")
        end

        if @tabScore[1] != nil
        	pseudo2.set_text(@tabScore[1].profil.pseudo)
        	temps2.set_text("#{@tabScore[1].getHeures}h#{@tabScore[1].getMinutes}m#{@tabScore[1].getSecondes}s")
        else
        	pseudo2.set_text("-")
        	temps2.set_text("-:-:-")
        end

        if @tabScore[2] != nil
            pseudo3.set_text(@tabScore[2].profil.pseudo)
            temps3.set_text("#{@tabScore[2].getHeures}h#{@tabScore[2].getMinutes}m#{@tabScore[2].getSecondes}s")
        else
            pseudo3.set_text("-")
            temps3.set_text("-:-:-")
        end

        if @tabScore[3] != nil
            pseudo4.set_text(@tabScore[3].profil.pseudo)
            temps4.set_text("#{@tabScore[3].getHeures}h#{@tabScore[3].getMinutes}m#{@tabScore[3].getSecondes}s")
        else
            pseudo4.set_text("-")
            temps4.set_text("-:-:-")
        end

        if @tabScore[4] != nil
            pseudo5.set_text(@tabScore[4].profil.pseudo)
            temps5.set_text("#{@tabScore[4].getHeures}h#{@tabScore[4].getMinutes}m#{@tabScore[4].getSecondes}s")
        else
            pseudo5.set_text("-")
            temps5.set_text("-:-:-")
        end

        if @tabScore[5] != nil
            pseudo6.set_text(@tabScore[5].profil.pseudo)
            temps6.set_text("#{@tabScore[5].getHeures}h#{@tabScore[5].getMinutes}m#{@tabScore[5].getSecondes}s")
        else
            pseudo6.set_text("-")
            temps6.set_text("-:-:-")
        end

        if @tabScore[6] != nil
            pseudo7.set_text(@tabScore[6].profil.pseudo)
            temps7.set_text("#{@tabScore[6].getHeures}h#{@tabScore[6].getMinutes}m#{@tabScore[6].getSecondes}s")
        else
            pseudo7.set_text("-")
            temps7.set_text("-:-:-")
        end

        if @tabScore[7] != nil
            pseudo8.set_text(@tabScore[7].profil.pseudo)
            temps8.set_text("#{@tabScore[7].getHeures}h#{@tabScore[7].getMinutes}m#{@tabScore[7].getSecondes}s")
        else
            pseudo8.set_text("-")
            temps8.set_text("-:-:-")
        end

        if @tabScore[8] != nil
            pseudo9.set_text(@tabScore[8].profil.pseudo)
            temps9.set_text("#{@tabScore[8].getHeures}h#{@tabScore[8].getMinutes}m#{@tabScore[8].getSecondes}s")
        else
            pseudo9.set_text("-")
            temps9.set_text("-:-:-")
        end

        if @tabScore[9] != nil
            pseudo10.set_text(@tabScore[9].profil.pseudo)
            temps10.set_text("#{@tabScore[9].getHeures}h#{@tabScore[9].getMinutes}m#{@tabScore[9].getSecondes}s")
        else
            pseudo10.set_text("-")
            temps10.set_text("-:-:-")
        end

        fenetre2.show_all
        Gtk.main
    end
end


unClassement = SauvegardeClassementSurvie.new




#unClassement.ajoutScore(score1)
#unClassement.ajoutScore(score2)

unClassement.afficheToi2
