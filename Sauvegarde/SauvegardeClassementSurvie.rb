load "Sauvegarde/Score.rb"
load "Sauvegarde/SauvegardeProfil.rb"

class SauvegardeClassementSurvie

    attr_accessor :tabScore, :nbScoreOccupe

    def initialize()
        if(!File.exist?("Sauvegarde/SauvegardeScore/scoreSurvie.dump"))
            @tabScore = Array.new(10)
            @nbScoreOccupe = 0; 
            File.open("Sauvegarde/SauvegardeScore/scoreSurvie.dump", "wb") { |file| file.write(Marshal.dump(@tabScore)) }
        else
            @tabScore = Marshal.load(File.binread("Sauvegarde/SauvegardeScore/scoreSurvie.dump"))
            @nbScoreOccupe = self.getNbScoreOccupe
        end
    end

    def ajoutScore(unScore)
        i = 0
        flagAjoute = 0
        # Parcours tous les scores et insert le score en fonction des autres
        while i < nbScoreOccupe && flagAjoute == 0
        	if unScore < @tabScore[i]
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

    def afficheToi
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
        	temps1.set_text("#{@tabScore[0]} grilles")
        else
        	pseudo1.set_text("-")
        	temps1.set_text("-:-")
        end

        if @tabScore[1] != nil
        	pseudo2.set_text(@tabScore[1].profil.pseudo)
        	temps2.set_text("#{@tabScore[1]} grilles")
        else
        	pseudo2.set_text("-")
        	temps2.set_text("-:-")
        end

        if @tabScore[2] != nil
            pseudo3.set_text(@tabScore[2].profil.pseudo)
            temps3.set_text("#{@tabScore[2]} grilles")
        else
            pseudo3.set_text("-")
            temps3.set_text("-:-")
        end

        if @tabScore[3] != nil
            pseudo4.set_text(@tabScore[3].profil.pseudo)
            temps4.set_text("#{@tabScore[3]} grilles")
        else
            pseudo4.set_text("-")
            temps4.set_text("-:-")
        end

        if @tabScore[4] != nil
            pseudo5.set_text(@tabScore[4].profil.pseudo)
            temps5.set_text("#{@tabScore[4]} grilles")
        else
            pseudo5.set_text("-")
            temps5.set_text("-:-")
        end

        if @tabScore[5] != nil
            pseudo6.set_text(@tabScore[5].profil.pseudo)
            temps6.set_text("#{@tabScore[5]} grilles")
        else
            pseudo6.set_text("-")
            temps6.set_text("-:-")
        end

        if @tabScore[6] != nil
            pseudo7.set_text(@tabScore[6].profil.pseudo)
            temps7.set_text("#{@tabScore[6]} grilles")
        else
            pseudo7.set_text("-")
            temps7.set_text("-:-")
        end

        if @tabScore[7] != nil
            pseudo8.set_text(@tabScore[7].profil.pseudo)
            temps8.set_text("#{@tabScore[7]} grilles")
        else
            pseudo8.set_text("-")
            temps8.set_text("-:-")
        end

        if @tabScore[8] != nil
            pseudo9.set_text(@tabScore[8].profil.pseudo)
            temps9.set_text("#{@tabScore[8]} grilles")
        else
            pseudo9.set_text("-")
            temps9.set_text("-:-")
        end

        if @tabScore[9] != nil
            pseudo10.set_text(@tabScore[9].profil.pseudo)
            temps10.set_text("#{@tabScore[9]} grilles")
        else
            pseudo10.set_text("-")
            temps10.set_text("-:-")
        end

        fenetre2.show_all
        Gtk.main
    end

end

classementSurvie = SauvegardeClassementSurvie.new
profil = Profil.new("Léo")
score1 = Score.new(50, profil)


classementSurvie.ajoutScore(score1)

classementSurvie.afficheToi()
