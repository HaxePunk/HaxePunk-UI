package haxepunk.ui;

import flash.text.TextFormatAlign;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import haxepunk.ui.skin.Skin;
import haxepunk.ui.skin.SkinImage;
import haxepunk.ui.skin.SkinToggleButtonElement;

typedef ToggleButtonCallback = Bool -> Void;

/**
 * A toggle button component
 */
class ToggleButton extends Button
{
	/**
	 * Boolean value indicating if the button has been toggled
	 */
	public var on:Bool = false;

	/**
	 * Graphic of the button when it's active, toggled, and it's not being pressed and the mouse is outside of it.
	 */
	public var normalOnGraphic:Graphic = new Graphic();
	/**
	 * Graphic of the button when the mouse hovers over the component, and it is active and toggled.
	 */
	public var mousedOnGraphic:Graphic = new Graphic();
	/**
	 * Graphic of the button when the mouse is pressing it, it's active and toggled.
	 */
	public var pressedOnGraphic:Graphic = new Graphic();
	/**
	 * Graphic of the button when inactive and toggled
	 */
	public var inactiveOnGraphic:Graphic = new Graphic();

	/**
	 * Constructor.
	 * @param	x			X-Coordinate of the component
	 * @param	y			Y-Coordinate of the component
	 * @param	width		Width of the component
	 * @param	height		Height of the Component
	 * @param	on			If button is toggled on
	 * @param	text		label for the component
	 * @param	onReleased	Function called when the mouse is released
	 * @param	hotkey		Hotkey used to trigger the component
	 * @param	skin		Skin to use when rendering the component
	 * @param	enabled		If the component is active
	 */
	public function new(x:Float = 0, y:Float = 0, width:Int = 1, height:Int = 1, on:Bool = false, text:String = "Button",
			onReleased:ToggleButtonCallback = null, hotkey:Int = 0, skin:Skin = null, enabled:Bool = true)
	{
		super(x, y, width, height, text, onReleased, hotkey, skin, enabled);

		this.on = on;
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (skin.punkToggleButton == null) return;

		setUpButtonSkin(skin.punkToggleButton);
		setUpToggleButtonSkin(skin.punkToggleButton);
		setUpLabel(skin.punkToggleButton.labelProperties);

		addGraphic(normalOnGraphic);
		addGraphic(label);
	}

	/**
	 * Additional setup steps for the component's toggle button skin
	 * @param	skin Skin to use when rendering the component
	 */
	function setUpToggleButtonSkin(skin:SkinToggleButtonElement):Void
	{
		if (skin == null) return;

		this.normalOnGraphic = getSkinImage(skin.normalOn);
		var mousedGraphic = getSkinImage(skin.mousedOn);
		this.mousedOnGraphic = (mousedGraphic != null) ? mousedGraphic : normalOnGraphic;
		var pressedGraphic = getSkinImage(skin.pressedOn);
		this.pressedOnGraphic = (pressedGraphic != null) ? pressedGraphic : normalOnGraphic;
		var inactiveGraphic = getSkinImage(skin.inactiveOn);
		this.inactiveOnGraphic = (inactiveGraphic != null) ? inactiveGraphic : normalOnGraphic;
	}

	override public function update():Void
	{
		super.update();

		var graphic:Graphiclist = cast graphic;
		if (enabled)
		{
			graphic.children[0] = switch (_currentGraphic)
			{
				case Normal:
					on ? normalOnGraphic : normalGraphic;
				case Hover:
					on ? mousedOnGraphic : mousedGraphic;
				case Pressed:
					on ? pressedOnGraphic : pressedGraphic;
			}
		}
		else
		{
			graphic.children[0] = on ? inactiveOnGraphic : inactiveGraphic;
		}
	}

	override function pressedCallback():Void
	{
		isPressed = true;
		if (onPressed != null) onPressed(on);
	}

	override function releasedCallback():Void
	{
		isPressed = false;
		on = !on;
		if (onReleased != null) onReleased(on);
	}

	override function enterCallback():Void
	{
		isMoused = true;
		if (onEnter != null) onEnter(on);
	}

	override function exitCallback():Void
	{
		isMoused = false;
		if (onExit != null) onExit(on);
	}
}
