import haxepunk.Scene;

import haxepunk.HXP;
import haxepunk.ui.Button;
import haxepunk.ui.MouseManager;

class PopupScene extends Scene
{
	public function new()
	{
		super();

		transparent = true;

		var mouseManager = new MouseManager();
		add(mouseManager);

		var btn = new Button(16, 16, 256, 256, "BIG BUTTON 2", function() HXP.engine.popScene(), mouseManager);
		add(btn);
	}
}
