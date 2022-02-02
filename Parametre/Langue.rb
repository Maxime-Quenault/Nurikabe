##
# Auteurs Moriceau Sanna Scherrer
# Version 0.2 : Date : Mon Jan 24 15:30:00 CET 2022
#
####

##
# Classe qui va gérer le choix d'une langue une fois l'appplication lancée (pas besoin de la redémarrer)

class Langue

    ## 
    # Tableau qui contient les langues (anglais seulement pour l'instant)
    attr_reader :langues

    ##
    # Langue actuelle
    attr_reader :langueActuelle

    ## 
    # Table de hashage permettant d'accéder au texte traduit dans différentes langues 
    attr_reader :dictionnaire

    private_class_method :new

    ##
    # Varialble de classe contenant l'unique instance de langue
    @@uneInstance = nil

    ## 
    # Méthode de création d'une langue
    # La création se fera en SINGLETON, c'est-à-dire qu'on va s'assurer de l'exsitence 
    # d'un seul objet de son genre et fournir un unique point d'accès vers cet objet
    def Langue.creer()
        if( @@uneInstance == nil )
            @@uneInstance = new
        end
        
        return @@uneInstance
    end

    ##
    # Getter de l'unique instance
    def self.getInstance()
        @@uneInstance
    end

    ##
    # Mise à jour de la langue
    #
    #   Paramètres :
    #        - id ==> id de la langue dans la table de hashage
    def utiliseLaLangue( unId )
        @dictionnaire = Marshal.load( File.binread( @fichiersLangues[unId] ) )
        @langueActuelle = unId
    end

    ##
    # Méthode d'initialisation de l'instance de Langue
    # Cette méthode sera appelée uniquement si la sauvegarde ne possède pas de langue
    #                                                            ==> inexistante ou corrompue
    def initialize()

        ###########
        # ANGLAIS #
        ###########

        @dictionnaire = Hash.new
        @dictionnaire["LIBRE"] = "Free play"
        @dictionnaire["CONTRELAMONTRE"] = "Time trial"
        @dictionnaire["SURVIE"] = "Survival"
        @dictionnaire["TUTORIEL"] = "Tutorial"
        @dictionnaire["CLASSEMENT"] = "Ranking"
        @dictionnaire["PARAMETRES"] = "Settings"
        @dictionnaire["A_PROPOS"] = "About"
        @dictionnaire["QUITTER"] = "Quit"
        @dictionnaire["FACILE"] = "Easy"
        @dictionnaire["MENU"] = "Menu"
        @dictionnaire["MOYEN"] = "Medium"
        @dictionnaire["DIFFICILE"] = "Hard"
        @dictionnaire["MEILLEUR_SCORE"] = "Best Score"
        @dictionnaire["ACTUALISER"] = "Refresh"
        @dictionnaire["RETOUR"] = "Back"
        @dictionnaire["JEU"] = "Game"
        @dictionnaire["UTILISATEUR"] = "User"
        @dictionnaire["INTERFACE"] = "Interface"
        @dictionnaire["REGLES"] = "Rules"
        @dictionnaire["AUDIO"] = "Audio"
        @dictionnaire["GRILLE"] = "Grid"
        @dictionnaire["PARTIE"] = "Game"
        @dictionnaire["AUCUN_RECORD"] = "No record"
        @dictionnaire["GRILLES"] = "Grids"
        @dictionnaire["MON_SCORE"] = "My time     "
        @dictionnaire["CASESGRISES"] = "Grey cells"
        @dictionnaire["COMPTEURILOTS"] = "Island counter"
        @dictionnaire["AFFICHERPORTER"] = "Island range"
        @dictionnaire["MURS2x2"] = "2x2 Walls"
        @dictionnaire["SUPPRIMER_SAUVEGARDE_PARTIE_EN_COURS"] = "Delete current game saves"
        @dictionnaire["RESET_PARAMETRE"] = "Reset to default settings"
        @dictionnaire["MODESOMBRE"] = "Dark mode"
        @dictionnaire["CHOISIRLANGUE"] = "Choose language"
        @dictionnaire["IMPORTERLANGUE"] = "Import language"
        @dictionnaire["SELECTION_MODE_LIBRE"] = "Grid selection"
        @dictionnaire["PARTIE_LIBRE"] = "Free play game"
        @dictionnaire["PARTIE_CLM"] = "Time trial game"
        @dictionnaire["OK"] = "Ok"
        @dictionnaire["PARTIE_SURVIE"] = "Survival game"
        @dictionnaire["OUI"] = "Yes"
        @dictionnaire["NON"] = "No"
        @dictionnaire["REPRENDRE_SAUVEGARDE"] = "Do you want to resume your saving ?"
        @dictionnaire["PARTIE_TUTORIEL"] = "Tutorial"

        # Technique de résolution
        @dictionnaire["ILE_1"] = "There is a cell next to an island with a value of 1, so it cannot be white"
        @dictionnaire["ILE_ADJACENTE"] = "There is a cell next to two islands, so it cannot be white otherwise the two islands would touch"
        @dictionnaire["ILE_ADJACENTE_DIAG"] ="There is a cell next to two islands, so it cannot be white otherwise the two islands would touch"
        @dictionnaire["ILE_COMPLETE"] = "There is a cell next to a completed island, so it cannot be white otherwise the island would be too big"
        @dictionnaire["CASE_ISOLEE"] = "There is an isolated cell: there is no path connecting it to an island"
        @dictionnaire["EXPENSION_MUR"] = "There is a wall that has only one way to expand to prevent it from being isolated"
        @dictionnaire["CONTINUITE_MUR"] = "There is a cell that has to be expanded to prevent two walls from being separated"
        @dictionnaire["EXPENSION_ILE"] = "There is a island that has onlu one way to expand in order to get developed"
        @dictionnaire["EXPENSION_2D"] = "There is an almost finished island that can only expand in two direcitons, both having an adjacent cell in common that cannot be white"
        @dictionnaire["EXPENSION_CACHEE"] = "There is a cell that has to be expanded for an island to develop enough"
        @dictionnaire["EVITER_2x2"] = "There is almost a 2x2 wall block, so the remaining cell cannot be black"
        @dictionnaire["CONTINUITE_ILE"] = "A white cell not connected to an island has to go through a cell to get to the island"
        @dictionnaire["ILE_INATTEIGNABLE"] = "A cell is too far from any island and cannot be reached"
        @dictionnaire["MSG_REGLE_ILE"] = "An island of size 4 must contain 4\nwhite cells surrounded by a black wall"
        @dictionnaire["MSG_REGLE_MUR"] = "The black wall must surround the\nislands and be continuous"
        @dictionnaire["MSG_REGLE_2x2"] = "The black wall cannot form 2x2 blocks"

        @dictionnaire["APROPOSCONTENT"] = "
                Nurikabe is a Japanese puzzle in the style of sudoku.
                
                This game, sometimes called \"island in the stream\", is a binary solving puzzle.
                
                One can decide, for each cell, if it is white or black according to very precise rules.
                
                The puzzle is solved on a rectangular grid of cells, some of which contain numbers.
                
                Two cells are connected if they are adjacent vertically or horizontally,
                but not diagonally.
                
                The white cells constitute the islands while the connected black cells constitute the
                the river.
                
                The player scores cells without numbers that he is sure belong to an island with one point.
                belong to an island.
                
                This application was developed within the framework of a university project by :
                
                    LEBOUC Julian
                    LOCHAIN Alexandre
                    MORICEAU Bastien
                    NOLIÈRE Alexis
                    QUENAULT Maxime
                    SANNA Florian
                    SCHERRER Arthur
                    TROTTIER Léo
                    VANNIER Allan
        "
        enregistreTmp("../Parametres/EN_en.dump")


        ############
        # FRANCAIS #
        ############

        @dictionnaire["LIBRE"] = "Libre"
        @dictionnaire["CONTRELAMONTRE"] = "Contre-La-Montre"
        @dictionnaire["SURVIE"] = "Survie"
        @dictionnaire["TUTORIEL"] = "Tutoriel"
        @dictionnaire["CLASSEMENT"] = "Classement"
        @dictionnaire["MENU"] = "Menu"
        @dictionnaire["PARAMETRES"] = "Paramètres"
        @dictionnaire["A_PROPOS"] = "À Propos"
        @dictionnaire["QUITTER"] = "Quitter"
        @dictionnaire["FACILE"] = "Facile"
        @dictionnaire["MOYEN"] = "Moyen"
        @dictionnaire["DIFFICILE"] = "Difficle"
        @dictionnaire["MEILLEUR_SCORE"] = "Meilleur Score"
        @dictionnaire["ACTUALISER"] = "Actualiser"
        @dictionnaire["RETOUR"] = "Retour"
        @dictionnaire["JEU"] = "Jeu"
        @dictionnaire["UTILISATEUR"] = "Utilisateur"
        @dictionnaire["INTERFACE"] = "Interface"
        @dictionnaire["REGLES"] = "Règles"
        @dictionnaire["AUDIO"] = "Audio"
        @dictionnaire["GRILLE"] = "Grille"
        @dictionnaire["PARTIE"] = "Partie"
        @dictionnaire["AUCUN_RECORD"] = "Aucun record"
        @dictionnaire["GRILLES"] = "Grilles"
        @dictionnaire["MON_SCORE"] = "Mon temps"
        @dictionnaire["CASESGRISES"] = "Cases grises"
        @dictionnaire["COMPTEURILOTS"] = "Compteur d'île"
        @dictionnaire["AFFICHERPORTER"] = "Portée d'île"
        @dictionnaire["MURS2x2"] = "Murs 2x2"
        @dictionnaire["SUPPRIMER_SAUVEGARDE_PARTIE_EN_COURS"] = "Supprimer les sauvegardes de parties en cours"
        @dictionnaire["RESET_PARAMETRE"] = "Remettre les paramètres par défaut"
        @dictionnaire["MODESOMBRE"] = "Mode sombre"
        @dictionnaire["CHOISIRLANGUE"] = "Choisir langue"
        @dictionnaire["IMPORTERLANGUE"] = "Importer langue"
        @dictionnaire["SELECTION_MODE_LIBRE"] = "Selection de grille"
        @dictionnaire["PARTIE_LIBRE"] = "Partie libre"
        @dictionnaire["PARTIE_CLM"] = "Partie contre-la-montre"
        @dictionnaire["OK"] = "Ok"
        @dictionnaire["PARTIE_SURVIE"] = "Partie survie"
        @dictionnaire["OUI"] = "Oui"
        @dictionnaire["NON"] = "Non"
        @dictionnaire["REPRENDRE_SAUVEGARDE"] = "Voulez-vous reprendre la sauvegarde ?"
        @dictionnaire["PARTIE_TUTORIEL"] = "Tutoriel"

        # Technique de résolution
        @dictionnaire["ILE_1"] = "Il existe une case adjacente à une île de valeur 1, et qui ne peut donc pas être blanche"
        @dictionnaire["ILE_ADJACENTE"] = "Il existe une case adjacente à deux îles, elle ne peut donc pas être blanche sinon les deux îles seraient collées"
        @dictionnaire["ILE_ADJACENTE_DIAG"] ="Il existe une case adjacente à deux îles, elle ne peut donc pas être blanche sinon les deux îles seraient collées"
        @dictionnaire["ILE_COMPLETE"] = "Il existe une case adjacente à une île complète, elle ne peut donc pas être blanche, sinon l'île déborderait"
        @dictionnaire["CASE_ISOLEE"] = "Il existe une case isolée : il n'y a aucun chemin qui la mène vers une île"
        @dictionnaire["EXPENSION_MUR"] = "Il existe une case d'expansion obligée pour éviter qu'un mur se retrouve isolé"
        @dictionnaire["CONTINUITE_MUR"] = "Il existe une case d'expansion obligée pour éviter que deux murs soient séparés"
        @dictionnaire["EXPENSION_ILE"] = "Il existe une case d'expansion obligée pour qu'une île se développe"
        @dictionnaire["EXPENSION_2D"] = "Il existe une île presque terminée qui ne peut s'étendre que dans deux direction, les deux ayant une case adjacente en commun qui ne pourra donc pas être blanche"
        @dictionnaire["EXPENSION_CACHEE"] = "Il existe une case d'expansion obligée pour qu'une île se dévelope assez"
        @dictionnaire["EVITER_2x2"] = "Il y a un presque un bloc de mur 2x2, la case restante ne peut donc pas être noire"
        @dictionnaire["CONTINUITE_ILE"] = "Une case blanche qui n'est pas reliée à une île passe nécessairement par une case pour rejoindre l'île"
        @dictionnaire["ILE_INATTEIGNABLE"] = "Une case est trop loin de toute île et est donc inatteignable"
        @dictionnaire["MSG_REGLE_ILE"] = "Une île de taille 4 doit être constituée de 4\ncases blanches entourées de murs noirs."
        @dictionnaire["MSG_REGLE_MUR"] = "Le mur de cases noires doit entourer\nles îles et être ininterrompu"
        @dictionnaire["MSG_REGLE_2x2"] = "Le mur de cases noires ne doit pas\nformer de carrés de taille 2x2"

        # TUTORIEL
        @dictionnaire["MSG_DEBUT_TUTO"] = "Bienvenue sur le tutoriel du Nurikabe !\nIci, nous allons te donner toutes les clés pour devenir un as de ce jeu.\nTu pourras survoler les boutons afin de découvrir à quoi ils servent.\nLes règles de base sont disponibles dans les paramètres.\nC'est parti !"
        @dictionnaire["ETAPE_1_TUTO"] = "Premièrement, deux îles ne peuvent pas être connectées.\nElles sont forcément séparées par une case noire."
        @dictionnaire["ETAPE_2_TUTO"] = "Lorsqu'une île a un indice de 1 (sa taille = 1), elle est automatiquement complète et doit être entourée de cases noires."
        @dictionnaire["ETAPE_3_TUTO"] =  "Les cases entourées de murs sont isolées et ne peuvent pas appartenir à une île et doivent donc être colorés en noir."
        @dictionnaire["ETAPE_4_TUTO"] =  "Tous les murs doivent former un chemin continu.\nIl ne peut pas y avoir un groupe de murs isolé."
        @dictionnaire["ETAPE_5_TUTO"] = "Une des règles du Nurikabe interdit les murs de 2x2 cases.\nCette configuration est donc impossible."
        @dictionnaire["ETAPE_6_TUTO"] = "Ces cases ne sont atteignables car elles se situent trop loin des îles.\nElle font donc partie d'un mur et doivent être noires."
        @dictionnaire["ETAPE_7_TUTO"] = "Lorsque 2 îles sont adjacentes en diagonale, les cases adjacentes en communs doivent être blanches pour éviter que les îles soient liées"
        @dictionnaire["ETAPE_8_TUTO"] = "S'il ne reste qu'une case pour compléter une île et qu'elle ne peut s'extendre que dans deux directions perpendiculaires, la case située en diagonale doit être noire car elle est adjacentes aux deux possibilités d'expansion."
        @dictionnaire["ETAPE_10_TUTO"] = "Lorsqu'un carré de mur 2x2 est presque formé, la case restante doit être coloriée en blanc pour éviter le carré noir."
        @dictionnaire["ETAPE_11_TUTO"] = "Une île complète doit être entourée de cases noires"

        @dictionnaire["POPUP_REGLAGES"] = "Réglages"
        @dictionnaire["POPUP_UNDO"] = "Retour arrière"
        @dictionnaire["POPUP_REDO"] = "Retour avant"
        @dictionnaire["POPUP_UNDOUNDO"] = "Retour dernière fois sans erreur"
        @dictionnaire["POPUP_PLAY"] = "Reprendre la partie"
        @dictionnaire["POPUP_PAUSE"] = "Mettre en pause"
        @dictionnaire["POPUP_HELP"] = "Demander une aide"
        @dictionnaire["POPUP_HELPLOCATION"] = "Afficher la localisation de l'erreur"
        @dictionnaire["POPUP_CLEAR"] = "Réinitialiser la grille"
        @dictionnaire["POPUP_CHECK"] = "Vérifier la grille"
        @dictionnaire["POPUP_QUIT"] = "Quitter la partie"
        @dictionnaire["APROPOSCONTENT"] = "
            Le Nurikabe est un puzzle japonais dans le style du sudoku.
            
            Ce jeu, quelquefois appelé « ilot dans le courant », est un puzzle à résolution binaire.
            
            On peut décider, pour chaque cellule, si elle est blanche ou noir en fonction de règles
            bien précises.
            
            Le puzzle se résout sur une grille rectangulaire de cellules, dont certaines contiennent
            des nombres.
            
            Deux cellules sont connectées si elles sont adjacentes verticalement ou horizontalement,
            mais pas en diagonale.
            
            Les cellules blanches constituent les îlots alors que les cellules noires connectées constituent
            le fleuve.
            
            Le joueur marque d'un point les cellules sans numéro dont il est sûr qu'elles appartiennent
            à un îlot.
            
            Cette application a été dévelopée dans le cadre d'un projet universitaire par :
                
                LEBOUC Julian
                LOCHAIN Alexandre
                MORICEAU Bastien
                NOLIÈRE Alexis
                QUENAULT Maxime
                SANNA Florian
                SCHERRER Arthur
                TROTTIER Léo
                VANNIER Allan
        "
      enregistreTmp("../Parametres/FR_fr.dump")

      @langues = [ "Français" , "Anglais" ]
      @fichiersLangues = [ "../Parametres/FR_fr.dump" , "../Parametres/EN_en.dump" ]
      @langueActuelle = 0
    end


    ##
    # Enregistrement d'un dictionnaire contenant une langue donnée
    #
    #   1 paramètre :
    #       unChemin ==> chemin ou les données doivent être enregistrées
    def enregistreTmp( unChemin )
        File.open( unChemin , "wb" ){ |f| f.write( Marshal.dump(@dictionnaire) ) }
        @dictionnaire = Marshal.load( File.binread( unChemin ) )
    end

    ## 
    # Renvoie le texte lié à la clé de hashage, ou INDEFINI si ce dernier n'existe pas
    #
    #   1 paramètre :
    #       unTexte ==> texte à renvoyer
    def getText( unTexte )
        if( @dictionnaire[unTexte] == nil )
                "INDEFINI" + unTexte.to_s
        end

        @dictionnaire[unTexte]
    end
end
