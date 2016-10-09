package haxepunk.ui;

import flash.display.BitmapData;
import flash.events.MouseEvent;
import flash.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import haxepunk.ui.UIComponent;
import haxepunk.ui.skin.SkinButtonElement;
import haxepunk.ui.skin.Skin;
import haxepunk.ui.skin.SkinImage;

typedef ButtonCallback = Function;

/**
 * A button component.
 */
class Button extends UIComponent
{
	/**
	 * Whether the button will respond to events.
	 */
	public var enabled:Bool = true;

	/**
	 * Function called when the button is pressed.
	 */
	public var onPressed:Dynamic = null;

	/**
	 * Function called when the button is released
	 */
	public var onReleased:Dynamic = null;

	/**
	 * Function called when the mouse first hovers over the button
	 */
	public var onEnter:Dynamic = null;

	/**
	 * Function called when the mouse first stops hovering over the button
	 */
	public var onExit:Dynamic = null;

	/**
	 * Is the button pressed
	 */
	public var isPressed:Bool = false;

	/**
	 * Is the button activated via the mouse
	 */
	public var isMoused:Bool = false;

	/**
	 * Is the button activated via the keyboard
	 */
	var isKeyed:Bool = false;

	/**
	 * Graphic of the button when it's active and it's not being pressed and the mouse is outside of it.
	 */
	public var normalGraphic:Graphic = new Graphic();
	/**
	 * Graphic of the button when the mouse overs it and it's active.
	 */
	public var mousedGraphic:Graphic = new Graphic();
	/**
	 * Graphic of the button when the mouse is pressing it and it's active.
	 */
	public var pressedGraphic:Graphic = new Graphic();
	/**
	 * Graphic of the button when inactive.
	 */
	public var inactiveGraphic:Graphic = new Graphic();

	/**
	 * Hotkey used to trigger this component
	 */
	public var hotkey:Int = 0;

	/**
	 * The button's label
	 */
	public var label:Text;

	/**
	 * Text string for this component
	 */
	var textString:String = "";

	/**
	 * Has the component been inititalized
	 */
	var initialized:Bool = false;

	/**
	 * Constructor
	 *
	 * @param x					The x coordinate of the button
	 * @param y					The y coordinate of the button
	 * @param width				The width of the button
	 * @param height			The height of the button
	 * @param text				The text of the button's label
	 * @param onReleased		What to do when the button is clicked.
	 * @param hotkey			Hotkey the trigger the component
	 * @param skin				The skin to use when rendering the component
	 * @param enabled			If the button should be active
	 */
	public function new(
		x:Float = 0,
		y:Float = 0,
		width:Int = 1,
		height:Int = 1,
		text:String = "Button",
		?onReleased:Dynamic,
		hotkey:Int = 0,
		?skin:Skin,
		enabled:Bool = true)
	{
		this.textString = text;

		super(x, y, width, height, skin);

		this.onReleased = onReleased;
		this.hotkey = hotkey;
		this.enabled = enabled;
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (skin.punkButton == null) return;

		setUpButtonSkin(skin.punkButton);
		setUpLabel(skin.punkButton.labelProperties);

		addGraphic(normalGraphic);
		addGraphic(label);
	}

	/**
	 * Additional setup specifically for the button's graphical states
	 * @param	skin Skin to use when rendering the component
	 */
	function setUpButtonSkin(skin:SkinButtonElement):Void
	{
		if (skin == null) return;

		this.normalGraphic = getSkinImage(skin.normal);
		var mousedGraphic = getSkinImage(skin.moused);
		this.mousedGraphic = (mousedGraphic != null) ? mousedGraphic : normalGraphic;
		var pressedGraphic = getSkinImage(skin.pressed);
		this.pressedGraphic = (pressedGraphic != null) ? pressedGraphic : normalGraphic;
		var inactiveGraphic = getSkinImage(skin.inactive);
		this.inactiveGraphic = (inactiveGraphic != null) ? inactiveGraphic : normalGraphic;
	}

	function setUpLabel(labelProperties:LabelOptions)
	{
		label = Label.getTextFromLabelOptions(labelProperties, textString, width, height);
	}

	/**
	 * Setup the different callbacks that this component uses
	 * @param	onReleased Function called when mouse is release
	 * @param	onPressed Function called when mouse is pressed
	 * @param	onEnter Function called when the mouse first hovers over the button
	 * @param	onExit Function called when the mouse stoppes hovering over the button
	 */
	public function setCallbacks(onReleased:Dynamic = null, onPressed:Dynamic = null, onEnter:Dynamic = null, onExit:Dynamic = null):Void
	{
		this.onReleased = onReleased;
		this.onPressed = onPressed;
		this.onEnter = onEnter;
		this.onExit = onExit;
	}

	override public function update():Void{
		super.update();

		if (!initialized)
		{
			HXP.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			HXP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			initialized = true;
		}

		if (hotkey != 0)
		{
			if (!isPressed && Input.pressed(hotkey))
			{
				isKeyed = true;
				pressedCallback();
			}
			if (isKeyed && Input.released(hotkey))
			{
				isKeyed = false;
				if (isPressed) releasedCallback();
			}
		}

		if (UI.mouseIsOver(this, true))
		{
			if (!isMoused) enterCallback();
			_currentGraphic = ButtonState.Hover;
		}
		else
		{
			if (isMoused) exitCallback();
			_currentGraphic = ButtonState.Normal;
		}

		if (isPressed) _currentGraphic = ButtonState.Pressed;

		var graphic:Graphiclist = cast graphic;
		if (enabled)
		{
			graphic.children[0] = switch (_currentGraphic)
			{
				case Normal:
					normalGraphic;
				case Hover:
					mousedGraphic;
				case Pressed:
					pressedGraphic;
			}
		}
		else
		{
			graphic.children[0] = inactiveGraphic;
		}

		var skinImage:SkinImage = cast graphic.children[0];
		skinImage.width = width;
		skinImage.height = height;
	}

	/**
	 * helper function to ensure the validity of a call to fire the onPressed function
	 */
	function pressedCallback():Void
	{
		isPressed = true;
		if (onPressed != null) onPressed();
	}

	/**
	 * helper function to ensure the validity of a call to fire the onRelease function
	 */
	function releasedCallback():Void
	{
		isPressed = false;
		if (onReleased != null) onReleased();
	}

	/**
	 * helper function to ensure the validity of a call to fire the onEnter function
	 */
	function enterCallback():Void
	{
		isMoused = true;
		if (onEnter != null) onEnter();
	}

	/**
	 * helper function to ensure the validity of a call to fire the onExit function
	 */
	function exitCallback():Void
	{
		isMoused = false;
		if (onExit != null) onExit();
	}

	function onMouseDown(e:MouseEvent = null):Void{
		if (!enabled || !Input.mousePressed || isPressed) return;
		if (isMoused) pressedCallback();
	}

	function onMouseUp(e:MouseEvent = null):Void{
		if (!enabled || !Input.mouseReleased || !isPressed) return;
		if (isPressed) isPressed = false;
		if (isMoused) releasedCallback();
	}

	override public function added():Void
	{
		super.added();

		initialized = false;

		if (HXP.stage != null)
		{
			HXP.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
			HXP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
			initialized = true;
		}
	}

	override public function removed():Void
	{
		super.removed();

		if (HXP.stage != null)
		{
			HXP.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			HXP.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
	}

	var _currentGraphic:ButtonState = ButtonState.Normal;
}

