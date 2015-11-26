using GLib;
using Gtk;

public class Main : Object 
{
	static int main (string[] args) 
	{
    	Gtk.init (ref args);

    	var window = new Gtk.Window ();
		window.title = "Hello World!";
		window.set_border_width (12);
		window.set_position (Gtk.WindowPosition.CENTER);
		window.set_default_size (350, 70);
		window.destroy.connect (Gtk.main_quit);


		var button_hello = new Gtk.Button.with_label ("Click me!");
		button_hello.clicked.connect (() => {
		    button_hello.label = "Hello World!";
		    button_hello.set_sensitive (false);
		});

		window.add (button_hello);
		window.show_all ();
		Gtk.main ();
		return 0;
	}
}

public class Board
{
	int width = 300;
	int delay = 100;
	int height = 270;
	int dotSize = 10;
	int randPos = 26;
}