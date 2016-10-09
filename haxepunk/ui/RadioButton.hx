package haxepunk.ui;

import haxepunk.ui.RadioButtonGroup;
import haxepunk.ui.ToggleButton;

import com.haxepunk.Graphic;

import haxepunk.ui.skin.Skin;

/**
 * Single radio button component
 */
class RadioButton extends ToggleButton
{
	/**
	 * Function called when this component is modified
	 */
	public var onChange:Function = null;

	/**
	 * The group of radior buttons that the component belongs to
	 */
	public var radioButtonGroup:RadioButtonGroup;

	/**
		 * Identification String for the component
		 */
	public var id:String;

	/**
	 * Constructor
	 * @param	radioButtonGroup The collection of buttons the component belongs in
	 * @param	id identification String of the component
	 * @param	x X-Coordinate of the component
	 * @param	y Y-Coordinate of the component
	 * @param	width Width of the component
	 * @param	height Height of the Component
	 * @param	on If button is toggled on
	 * @param	text label for the component
	 * @param	onChange Function called when the state is changed
	 * @param	hotkey Hotkey used to trigger the component
	 * @param	skin Skin to use when rendering the component
	 * @param	active If the component is active
	 */
	public function new(radioButtonGroup:RadioButtonGroup, id:String, x:Float = 0, y:Float = 0, width:Int = 1, height:Int = 1, on:Bool = false, text:String = "Radio button", onChange:Function = null, hotkey:Int = 0, skin:Skin = null, active:Bool = true)
	{
		super(x, y, width, height, on, text, null, hotkey, skin, active);

		this.onChange = onChange;
		this.radioButtonGroup = radioButtonGroup;
		this.id = id;

		radioButtonGroup.add(this);
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (!skin.punkRadioButton) return;

		setUpButtonSkin(skin.punkRadioButton);
		setUpToggleButtonSkin(skin.punkRadioButton);
	}

	/**
	 * Clean up this component
	 */
	public function dispose():Void
	{
		radioButtonGroup.remove(this);
	}

	override function releasedCallback():Void
	{
		isPressed = false;
		radioButtonGroup.toggleOn(this);
		if (onReleased != null) onReleased(on);
	}

	/**
	 * Change the state of the component
	 * @param	on If the component should be in the on state
	 */
	function toggle(on:Bool):Void
	{
		this.on = on;
		if (onChange != null) onChange(on);
	}

	override public function removed():Void
	{
		super.removed();

		dispose();
	}
}
