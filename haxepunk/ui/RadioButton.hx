package haxepunk.ui;

import haxepunk.ui.RadioButtonGroup;
import haxepunk.ui.ToggleButton;

import com.haxepunk.Graphic;

import haxepunk.ui.skin.Skin;

/**
 * Single radio button component
 */
@:allow(haxepunk.ui.RadioButtonGroup)
class RadioButton extends ToggleButton
{
	/**
	 * Function called when this component is modified
	 */
	public var onChange:ButtonCallback = null;

	/**
	 * The group of radior buttons that the component belongs to
	 */
	public var radioButtonGroup:RadioButtonGroup;

	/**
	 * Identification String for the component
	 */
	public var id:String;

	/**
	 * @param	radioButtonGroup	The collection of buttons the component belongs in
	 * @param	id					identification String of the component
	 * @param	x					X-Coordinate of the component
	 * @param	y					Y-Coordinate of the component
	 * @param	width				Width of the component
	 * @param	height				Height of the Component
	 * @param	on					If button is toggled on
	 * @param	text				label for the component
	 * @param	onChange			Function called when the state is changed
	 * @param	hotkey				Hotkey used to trigger the component
	 * @param	skin				Skin to use when rendering the component
	 * @param	enabled				If the component is active
	 * @param	mouseManager		MouseManager to handle this button's mouse events
	 */
	public function new(
		radioButtonGroup:RadioButtonGroup,
		id:String,
		x:Float = 0,
		y:Float = 0,
		width:Int = 1,
		height:Int = 1,
		?on:Bool = false,
		?text:String = "Radio button",
		?onChange:ButtonCallback = null,
		?hotkey:Int = 0,
		?skin:Skin = null,
		?enabled:Bool = true,
		?mouseManager:MouseManager)
	{
		super(x, y, width, height, on, text, null, hotkey, skin, enabled, mouseManager);

		this.onChange = onChange;
		this.radioButtonGroup = radioButtonGroup;
		this.id = id;

		radioButtonGroup.add(this);
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin	Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (skin.radioButton == null) return;

		setUpButtonSkin(skin.radioButton);
		setUpToggleButtonSkin(skin.radioButton);
		setUpLabel(skin.toggleButton.labelProperties);

		addGraphic(normalGraphic);
		addGraphic(label);
	}

	override function setLabelPosition(lastGraphic:ButtonState) {}

	/**
	 * Change the state of the component
	 * @param	on	If the component should be in the on state
	 */
	function toggle(on:Bool):Void
	{
		this.on = on;
		if (onChange != null) onChange();
	}
}
