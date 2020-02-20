public class Timecraft.RetroGame.SystemGrid : Gtk.EventBox {

    private int cells_width = 4;

    private int current_cell_x = -1;
    private int current_cell_y = 0;

    private Gtk.Grid systems;
    
    public static SystemGrid? instance;
    
    private Granite.Widgets.Welcome welcome;
    
    

    //public signal void activated (int index);

    //protected new GLib.List<Gtk.Button> children = new GLib.List<Gtk.Button> ();

    public SystemGrid () {
        
        add_systems ();
        
        add (systems);
        
        instance = this;
        
    }
    
    public void add_systems () {
        if (instance != null) {
            instance.destroy ();
        }
        if (systems != null) {
            systems.destroy ();
        }
        
        systems = new Gtk.Grid ();
    
        
        if (Application.instance.systems_found) {
        
            foreach (System current_system in Application.instance.systems) {
                message (current_system.path);
                var button = new SystemButton (current_system);
                    if (current_cell_x > cells_width) {
                    current_cell_y ++;
                    current_cell_x = -1;
                }
                systems.attach (button, current_cell_x++, current_cell_y, 1, 1);


            

            }   
    
            systems.expand = true;
            systems.margin = 20;
            systems.orientation = Gtk.Orientation.HORIZONTAL;
            systems.halign = Gtk.Align.CENTER;
            systems.valign = Gtk.Align.START;
    
            systems.set_column_homogeneous (true);
            systems.set_column_spacing (20);
            systems.set_row_homogeneous (true);
            systems.set_row_spacing (20);
            
        }
        else {
            //weak Gtk.IconTheme icon_theme = Application.instance.default_theme;
            
            Gtk.Image input_gaming_new = new Gtk.Image.from_icon_name ("com.github.timecraft.retro", Gtk.IconSize.INVALID);
            input_gaming_new.pixel_size = 128;
            input_gaming_new.margin_bottom = 12;
            input_gaming_new.icon_name = "input-gaming-new";
            welcome = new Granite.Widgets.Welcome ("Install a system", "");
            welcome.append_with_image (input_gaming_new, "Install a system", "");
            systems.attach (welcome, 0,0,1,1);
            
            welcome.activated.connect (() => {
                new InstallCore ();
                
            });
            
        }

    }
    
    public void update_systems () {
        remove (systems);
        systems.destroy ();
        systems = new Gtk.Grid ();
        add_systems ();
        MainWindow.instance.show_all ();
    }

}