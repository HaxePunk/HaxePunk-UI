package haxepunk.ui;

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

/**
 * A button component.
 */
class Button extends UIComponent
{
	public var mouseManager(default, set):MouseManager;
	inline function set_mouseManager(manager:MouseManager)
	{
		if (mouseManager != null)
		{
			mouseManager.remove(this);
		}
		if (manager != null)
		{
			manager.add(this, pressedCallback, releasedCallback, enterCallback, exitCallback);
		}
		return this.mouseManager = manager;
	}

	/**
	 * Whether the button will respond to events.
	 */
	public var enabled:Bool = true;

	/**
	 * Function called when the button is pressed.
	 */
	public var onPressed:ButtonCallback = null;

	/**
	 * Function called when the button is released
	 */
	public var onReleased:ButtonCallback = null;

	/**
	 * Function called when the mouse first hovers over the button
	 */
	public var onEnter:ButtonCallback = null;

	/**
	 * Function called when the mouse first stops hovering over the button
	 */
	public var onExit:ButtonCallback = null;

	/**
	 * Is the button pressed
	 */
	public var isPressed:Bool = false;

	/**
	 * Is the button activated via the mouse
	 */
	public var isHovered:Bool = false;

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
	 * Amount to add to label Y coordinate when this button is pressed.
	 */
	public var labelPressedOffset:Int = 2;

	/**
	 * The button's label
	 */
	public var label:Text;
	var labelY:Float = 0;

	/**
	 * Text string for this component
	 */
	var textString:String = "";

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
		?onReleased:ButtonCallback,
		?hotkey:Int = 0,
		?skin:Skin,
		?enabled:Bool = true,
		?mouseManager:MouseManager
		)
	{
		this.textString = text;

		super(x, y, width, height, skin);

		this.onReleased = onReleased;
		this.hotkey = hotkey;
		this.enabled = enabled;
		this.mouseManager = mouseManager;
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (skin.button == null) return;

		setUpButtonSkin(skin.button);
		setUpLabel(skin.button.labelProperties);

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
		labelY = label.y;
	}

	/**
	 * Setup the different callbacks that this component uses
	 * @param	onReleased Function called when mouse is release
	 * @param	onPressed Function called when mouse is pressed
	 * @param	onEnter Function called when the mouse first hovers over the button
	 * @param	onExit Function called when the mouse stoppes hovering over the button
	 */
	public function setCallbacks(onReleased:ButtonCallback = null, onPressed:ButtonCallback = null, onEnter:ButtonCallback = null, onExit:ButtonCallback = null):Void
	{
		this.onReleased = onReleased;
		this.onPressed = onPressed;
		this.onEnter = onEnter;
		this.onExit = onExit;
	}

	override public function update():Void
	{
		super.update();

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

		if (isPressed) _currentGraphic = ButtonState.Pressed;
		label.y = labelY + labelPressedOffset * (isPressed ? 1 : 0);

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
		if (!enabled) return;
		isPressed = true;
		setCurrentGraphic();
		if (onPressed != null) onPressed();
	}

	/**
	 * helper function to ensure the validity of a call to fire the onRelease function
	 */
	function releasedCallback():Void
	{
		if (!isPressed) return;
		isPressed = false;
		setCurrentGraphic();
		if (onReleased != null) onReleased();
	}

	/**
	 * helper function to ensure the validity of a call to fire the onEnter function
	 */
	function enterCallback():Void
	{
		isHovered = true;
		setCurrentGraphic();
		if (onEnter != null) onEnter();
	}

	/**
	 * helper function to ensure the validity of a call to fire the onExit function
	 */
	function exitCallback():Void
	{
		isHovered = isPressed = false;
		setCurrentGraphic();
		if (onExit != null) onExit();
	}

	function setCurrentGraphic()
	{
		var lastGraphic = _currentGraphic;
		if (isPressed)
		{
			_currentGraphic = ButtonState.Pressed;
		}
		else if (isHovered)
		{
			_currentGraphic = ButtonState.Hover;
		}
		else
		{
			_currentGraphic = ButtonState.Normal;
		}
	}

	override public function added():Void
	{
		super.added();
	}

	override public function removed():Void
	{
		super.removed();
	}

	var _currentGraphic:ButtonState = ButtonState.Normal;
}

