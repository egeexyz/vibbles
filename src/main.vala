using GLib;
using Gtk;

public class Main : Object 
{
	static int main (string[] args) 
	{
		//window.set_border_width (12); //TODO: What is this?

    	Gtk.init (ref args);    	
    	var window = new Gtk.Window ();
    	var board = new Board();

    	//Window Properties
		window.title = "vibbles";
		window.set_position (Gtk.WindowPosition.CENTER);
		window.set_default_size (board.Width, board.Height);
		window.destroy.connect (Gtk.main_quit);


		var button_hello = new Gtk.Button.with_label ("Click me!");
		button_hello.clicked.connect (() => {
		    button_hello.label = "Hello World!";
		    button_hello.set_sensitive (false);
		});

		window.add (button_hello); //This is probably how we will add things

		//Start Your Engines!
		window.show_all ();
		Gtk.main ();
		return 0;
	}
}

public class Board
{
	public int Width { get; set; }
	public int Height { get; set; }	
	public int Delay { get; set; }
	public int DotSize { get; set; }
	public int RandPos { get; set; }

	public Board()
	{
		Width = 800;
		Height = 400;
		Delay = 100;
		DotSize = 10;
		RandPos = 26;
	}
}