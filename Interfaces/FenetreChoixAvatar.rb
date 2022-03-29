require 'gtk3'
include Gtk

class FenetreChoixAvatar

    attr_accessor :choixAvatar, :quit

    def initialize(image)
        @quit = false
        @popUpAvatar = Window.new()
        @choixAvatar = image
    end

    ##
    # setMargin :
    #   ???
    #
    def setmargin(obj, top, bottom, left, right)
        obj.set_margin_top(top)
        obj.set_margin_bottom(bottom)
        obj.set_margin_left(left)
        obj.set_margin_right(right)
        return obj
    end

    def afficheToi
        @popUpAvatar = Window.new()
        @popUpAvatar.set_title("Modifier avatar")
        @popUpAvatar.border_width=10
        @popUpAvatar.set_resizable(false)
        @popUpAvatar.set_window_position(Gtk::WindowPosition::CENTER_ALWAYS)
        @popUpAvatar.signal_connect('destroy') {destruction}
        @popUpAvatar.add(laFenetrePrincipale=Gtk::Box.new(:vertical, 2))

        laFenetrePrincipale.add(haut=Gtk::Box.new(:horizontal, 3))

        pixbuf = GdkPixbuf::Pixbuf.new(:file => "Image/dog.png")
        pixbuf = pixbuf.scale_simple(70, 70, Gdk::Pixbuf::INTERP_BILINEAR)
        imageDog = Gtk::Image.new
        imageDog.set_from_pixbuf(pixbuf)
        boutonDog = Button.new()
        boutonDog.image = imageDog

        haut.add(setmargin(boutonDog, 0, 0, 0, 0))

        pixbuf = GdkPixbuf::Pixbuf.new(:file => "Image/dog-angry.png")
        pixbuf = pixbuf.scale_simple(70, 70, Gdk::Pixbuf::INTERP_BILINEAR)
        imageDogAngry = Gtk::Image.new
        imageDogAngry.set_from_pixbuf(pixbuf)
        boutonDogAngry = Button.new()
        boutonDogAngry.image = imageDogAngry

        haut.add(setmargin(boutonDogAngry, 0, 0, 0, 0))

        pixbuf = GdkPixbuf::Pixbuf.new(:file => "Image/dog-cool.png")
        pixbuf = pixbuf.scale_simple(70, 70, Gdk::Pixbuf::INTERP_BILINEAR)
        imageDogCool = Gtk::Image.new
        imageDogCool.set_from_pixbuf(pixbuf)
        boutonDogCool = Button.new()
        boutonDogCool.image = imageDogCool

        haut.add(setmargin(boutonDogCool, 0, 0, 0, 0))

        laFenetrePrincipale.add(bas=Gtk::Box.new(:horizontal, 3))

        pixbuf = GdkPixbuf::Pixbuf.new(:file => "Image/dog-cry.png")
        pixbuf = pixbuf.scale_simple(70, 70, Gdk::Pixbuf::INTERP_BILINEAR)
        imageDogCry = Gtk::Image.new
        imageDogCry.set_from_pixbuf(pixbuf)
        boutonDogCry = Button.new()
        boutonDogCry.image = imageDogCry

        bas.add(setmargin(boutonDogCry, 0, 0, 0, 0))

        pixbuf = GdkPixbuf::Pixbuf.new(:file => "Image/dog-love.png")
        pixbuf = pixbuf.scale_simple(70, 70, Gdk::Pixbuf::INTERP_BILINEAR)
        imageDogLove = Gtk::Image.new
        imageDogLove.set_from_pixbuf(pixbuf)
        boutonDogLove = Button.new()
        boutonDogLove.image = imageDogLove

        bas.add(setmargin(boutonDogLove, 0, 0, 0, 0))

        pixbuf = GdkPixbuf::Pixbuf.new(:file => "Image/dog-kiss.png")
        pixbuf = pixbuf.scale_simple(70, 70, Gdk::Pixbuf::INTERP_BILINEAR)
        imageDogKiss = Gtk::Image.new
        imageDogKiss.set_from_pixbuf(pixbuf)
        boutonDogKiss = Button.new()
        boutonDogKiss.image = imageDogKiss

        bas.add(setmargin(boutonDogKiss, 0, 0, 0, 0))

        boutonDog.signal_connect('clicked'){
            @choixAvatar = "Image/dog.png"
            event(@popUpAvatar)
        }

        boutonDogAngry.signal_connect('clicked'){
            @choixAvatar = "Image/dog-angry.png"
            event(@popUpAvatar)
        }

        boutonDogCool.signal_connect('clicked'){
            @choixAvatar = "Image/dog-cool.png"
            event(@popUpAvatar)
        }

        boutonDogLove.signal_connect('clicked'){
            @choixAvatar = "Image/dog-love.png"
            event(@popUpAvatar)
        }

        boutonDogCry.signal_connect('clicked'){
            @choixAvatar = "Image/dog-cry.png"
            event(@popUpAvatar)
        }

        boutonDogKiss.signal_connect('clicked'){
            @choixAvatar = "Image/dog-kiss.png"
            event(@popUpAvatar)
        }

        @popUpAvatar.show_all

        Gtk.main           
    end

    ##
    # event :
    #   Cette méthode permet de cacher la fenetre lorsque l'utilisateur a choisi/créé un profil
    #   @param popUpProfil represente la fenetre à cacher.
    def event(popUpProfil)
        popUpProfil.hide
        Gtk.main_quit  
    end

    ##
    # destruction :
    #   Cette méthode permet de supprimer la fenetre si l'utilisateur la ferme. Elle met donc le boolean "@quit" à jour.
    def destruction()
        @quit = true
        Gtk.main_quit  
    end

end