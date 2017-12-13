using Cairo;
using Gtk;
using Gdk;

public class Main : Gtk.Window
{
	public static int main (string[] args)
	{
    //Get GTK ready to rock and roll
  	Gtk.init (ref args);
  	var window = new Gtk.Window();
  	var board = new Board();

  	//Setup Our Window Properties
		window.title = "Vibbles!";
		window.set_position (Gtk.WindowPosition.CENTER);
		window.set_default_size (300, 270);
		window.set_events(Gdk.EventMask.BUTTON_PRESS_MASK);

		//Wire Up Our Signals
		window.destroy.connect (Gtk.main_quit);
		window.key_press_event.connect ((event) => {
			board.OnKeyPress(event.keyval);
			return true;
			});

		//Kick Off The GTK Loop And Away We Go!
		window.icon = new Pixbuf.from_file ("src/assets/vibbles.png");
		window.add(board);
		window.show_all ();
		Gtk.main ();
		return 0;
	}
}

public class Board : DrawingArea
{
	public int Width { get; set; }
	public int Height { get; set; }
	public int DotSize { get; set; }
	public int AllDots { get; set; }
	public int RandPos { get; set; }
	public int Delay { get; set; }
	private int[] X {get;set;}
	private int[] Y {get;set;}

	private bool Left{get;set;}
	private bool Right {get;set;}
	private bool Up {get;set;}
	private bool Down {get;set;}
	private bool InGame{get;set;}
	public int Dots {get;set;}

	public Pixbuf Dot { get; set; }
	public Pixbuf Head { get; set; }
	public Pixbuf Apple { get; set; }

	public int AppleX{get;set;}
	public int AppleY{get;set;}

	public Board()
	{
		Width = 300;
		Delay = 1;
		Height = 270;
		DotSize = 10;
		RandPos = 26;
		AllDots = Width * Height / (DotSize * DotSize);

		Dot = new Pixbuf.from_file("src/assets//head.png");
		Head = new Pixbuf.from_file("src/assets//dot.png");
		Apple = new Pixbuf.from_file("src/assets/apple.png");

		Left = false;
		Right = true;
		Up = false;
		Down = false;
		Dots = 3;

		X = new int[AllDots];
		Y = new int[AllDots];

		InGame = true;
		OnDraw();
		InitGame();
	}

	public bool OnTimer()
	{
		if (InGame)
		{
			CheckApple();
			CheckCollision();
			Move();
			queue_draw();
			return true;
		}
		else
			return false;

		this.draw.connect ((context) => {
			return true;
		});
	}

	public void InitGame()
	{
		LocateApple();
		OnTimer();
		GLib.Timeout.add(400, OnTimer);
	}

	public DrawingArea OnDraw() {
		print (InGame.to_string());
		if (InGame)
			DrawObjects(this);
		else
			GameOver(this);

		return this;
	}

	public void DrawObjects(DrawingArea drawingArea)
	{
		this.draw.connect ((context) => {
			context.set_source_rgb(0, 0, 0);
			context.paint();

			cairo_set_source_pixbuf(context, Apple, AppleX, AppleY);
			context.paint();

			cairo_set_source_pixbuf(context, Head, AllDots, AllDots);
			context.paint();

			var array = new int[Dots];

			for (int i = 0; i < Dots; i++)
			{
				array[i] = i;
			}

			foreach (var i in array)
			{
				if (i == 0)
				{
					cairo_set_source_pixbuf(context, Head, X[i], Y[i]);
					context.paint();
				}
				else
				{
					cairo_set_source_pixbuf(context, Dot, X[i], Y[i]);
					context.paint();
				}
			};
			if (InGame == false)
				GameOver(this);
			return true;
		});
	}

	public void GameOver(DrawingArea drawingArea)
	{
		print("Game Over\n");
		Gtk.main_quit();
	}

	public void CheckApple()
	{
		if (X[0] == AppleX && Y[0] == AppleX)
		{
			Dots = Dots + 1;
			LocateApple();
		}
	}

	public void Move()
	{
		var z = Dots;

		while (z > 0)
		{
			X[z] = X[(z - 1)];
			Y[z] = Y[(z - 1)];
			z = z - 1;
		}

		if (Left)
			X[0] -= DotSize;

		if (Right)
			X[0] += DotSize;

		if (Up)
			Y[0] -= DotSize;

		if (Down)
			Y[0] += DotSize;
	}

	public void CheckCollision()
	{
		var z = Dots;

		while (z > 0)
		{
			if (z > 4 && X[0] == X[z] && Y[0] == Y[z])
				InGame = false;
			z = z - 1;
		}

		if (Y[0] > Height - DotSize){
	    	InGame = false;
		}

		if (Y[0] < 0){
	    	InGame = false;
		}

		if (X[0] > Width - DotSize){
	    	InGame = false;
		}

		if (X[0] < 0){
	    	InGame = false;
		}
	}

	public void LocateApple()
	{
		var randomNumber = Random.int_range(0,RandPos);

		AppleX = randomNumber * DotSize;
		AppleY = randomNumber * DotSize;
	}

	public void OnKeyPress(uint val)
	{
		if (val == Gdk.Key.Left)
		{
			Left = true;
			Up = false;
			Down = false;
		}
		if (val == Gdk.Key.Right)
		{
			Right = true;
			Up = false;
			Down = false;
		}
		if (val == Gdk.Key.Up)
		{
			Up = true;
			Right = false;
			Left = false;
		}
		if (val == Gdk.Key.Down)
		{
			Down = true;
			Right = false;
			Left = false;
		}
	}
}
