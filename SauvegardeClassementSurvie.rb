require "yaml.rb"
require 'gtk3'
include Gtk
load "Score.rb"
load "SauvegardeProfil.rb"

class SauvegardeClassementSurvie

	def initialize()
        if(!File.exist?("./SauvegardeScore/scoreSurvie.yml"))
            @tabScore = Array.new(10)
            File.open("./SauvegardeScore/scoreSurvie.yml", "w") { |file| file.write(tabScore.to_yaml) }
        else
            @tabScore = YAML.load(File.read("./SauvegardeScore/scoreSurvie.yml"))
        end
    end


    #
    # ici quand j'ajoute un score je trie le tableau des scores en même temps
    # ce qui permet de toujours garder un tableau de score de 10 de longueur et des scores toujours triés
    # or j'ai une erreur dans le while avec tabTampon[y] = .. regarde si tu peux.
    #
    def ajoutScore(unScore)
        @tabScore = YAML.load(File.read("./SauvegardeScore/scoreSurvie.yml"))
        #inclure le module comparable à la classe Score
        tabTampon = Array.new(10)
        i = 0
        y = 0
        #on compare avec une valeur nil, donc marche pas, à corriger.
        while y < 10
        	if unScore < @tabScore[i]
        		tabTampon[y] = unScore
        		y = y+1
        	else
        		tabTampon[y] = @tabScore[i]
        		y = y+1
        		i = i+1
        	end
        end
        @tabScore = tabTampon
        File.open("./SauvegardeScore/scoreSurvie.yml", "w") { |file| file.write(tabScore.to_yaml) }
    end

    def afficheToi
        Gtk.init

        monBuilder = Gtk::Builder.new
        monBuilder.add_from_file("glade/Survie_nouvelle_partie.glade") 
        monBuilder.connect_signals {|handler| method(handler) }

        #recuperation des variables

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

        # a faire pour tous les temps
        # 		.
        #		.
        # 		.
        #		.
        # 		.
        #		.
        #


        Gtk.main
    end
end


unClassement = SauvegardeClassementSurvie.new
profil1 = Profil.new("Maxime")
profil2 = Profil.new("Leo")
score1 = Score.new(256, profil1)
score2 = Score.new(326, profil2)


unClassement.ajoutScore(score1)
unClassement.ajoutScore(score2)

unClassement.afficheToi
