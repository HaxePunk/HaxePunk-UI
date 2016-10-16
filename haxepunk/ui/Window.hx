package haxepunk.ui;

import haxepunk.Graphic;
import haxepunk.graphics.Image;
import haxepunk.utils.Input;
import haxepunk.ui.skin.Skin;

/**
 * A window component
 */
class Window extends Panel
{
	/**
	 * If the component is being moved
	 */
	var dragging:Bool = false;

	/**
	 * If the component can be dragged by the user using the mouse.
	 */
	public var draggable:Bool = true;

	/**
	 * Offset used to track the Mouse's X-Coordinate
	 */
	var mouseOffsetX:Float = 0;
	/**
	 * Offset used to track the Mouse's Y-Coordinate
	 */
	var mouseOffsetY:Float = 0;

	/**
	 * The component's caption String
	 */
	var captionString:String = "";

	/**
	 * The graphical representation of its caption String
	 */
	public var caption:Text;

	/**
	 * Image used for the component's bar
	 */
	var bar:Image;
	/**
	 * Image used for the component's background
	 */
	var bg:Image;

	/**
	 * Constructor
	 * @param	x X-Coordinate of the component
	 * @param	y Y-Coordinate of the component
	 * @param	width Width of the component
	 * @param	height Height of the component
	 * @param	caption String for the component's caption
	 * @param	draggable Whether the component can be dragged by the user using the mouse.
	 * @param	skin Skin to use when rendering the component
	 */
	public function new(x:Float = 0, y:Float = 0, width:Int = 20, height:Int = 20, caption:String = "", draggable:Bool = true, skin:Skin = null)
	{
		captionString = caption;
		super(x, y, width, height, skin);

		this.draggable = draggable;

		if (bg != null) graphiclist.add(bg);
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (!skin.punkWindow) return;

		caption = new Text(captionString, 0, 0, skin.punkWindow.labelProperties);
		var barHeight:Int = skin.punkWindow.bar.height;
		bar = getSkinImage(skin.punkWindow.bar, 0, barHeight);
		bg = getSkinImage(skin.punkWindow.body, 0, height - barHeight);
		bg.y = barHeight;
	}

	override public function update():Void
	{
		super.update();

		if (!draggable) return;

		if (Input.mousePressed && UI.mouseIsOver(this))
		{
			dragging = true;
			mouseOffsetX = x - world.mouseX;
			mouseOffsetY = y - world.mouseY;
			if (world) world.bringToFront(this);
		}

		if (dragging)
		{
			x = mouseOffsetX + world.mouseX;
			y = mouseOffsetY + world.mouseY;
		}

		if (Input.mouseReleased) dragging = false;
	}

	override public function render():Void
	{
		super.render();

		renderGraphic(bar);
		renderGraphic(caption);
	}
}
