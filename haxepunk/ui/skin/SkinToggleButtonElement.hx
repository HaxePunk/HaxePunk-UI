package haxepunk.ui.skin;

import haxepunk.graphics.Text;

/**
 * Base classed used to create a custom toggle button skin
 */
class SkinToggleButtonElement extends SkinButtonElement
{
	/**
	 * Image used when the toggle button is in its normal toggled state
	 */
	public var normalOn:SkinImage;
	/**
	 * Image used when the toggle button is in its mouse over toggled state
	 */
	public var mousedOn:SkinImage;
	/**
	 * Image used when the toggle button is in its mouse pressed toggled state
	 */
	public var pressedOn:SkinImage;
	/**
	 * Image used when the toggle button is in its inactive toggled state
	 */
	public var inactiveOn:SkinImage;

	/**
	 * Constructor.
	 * @param	normal Normal state image
	 * @param	moused Mouse over state image
	 * @param	pressed Mouse pressed image
	 * @param	inactive Inactive state image
	 * @param	normalOn Normal toggled image
	 * @param	mousedOn Mouse over toggled image
	 * @param	pressedOn Mouse pressed toggled image
	 * @param	inactiveOn Inactive toggled image
	 * @param	labelProperties optional properties for the label
	 */
	public function new(?normal:SkinImage, ?moused:SkinImage, ?pressed:SkinImage, ?inactive:SkinImage, ?normalOn:SkinImage, ?mousedOn:SkinImage, ?pressedOn:SkinImage, ?inactiveOn:SkinImage, ?labelProperties:LabelOptions)
	{
		super(normal, moused, pressed, inactive, labelProperties);

		this.normalOn = normalOn;
		this.mousedOn = mousedOn;
		this.pressedOn = pressedOn;
		this.inactiveOn = inactiveOn;
	}
}
