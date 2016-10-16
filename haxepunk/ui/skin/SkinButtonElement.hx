package haxepunk.ui.skin;

import haxepunk.graphics.Text;
import haxepunk.ui.skin.SkinHasLabelElement;
import haxepunk.ui.skin.SkinImage;

/**
 * Base class used to create a custom Button skin.
 */
class SkinButtonElement extends SkinHasLabelElement
{
	/**
	 * Image used when the button is in its normal state
	 */
	public var normal:SkinImage;
	/**
	 * Image used when the button is in its mouse over state
	 */
	public var moused:SkinImage;
	/**
	 * Image used when the button is in its pressed state
	 */
	public var pressed:SkinImage;
	/**
	 * Image used when the button is in its inactive state
	 */
	public var inactive:SkinImage;

	/**
	 * Constructor.
	 * @param	normal Normal state image
	 * @param	moused Mouse over state image
	 * @param	pressed Mouse pressed state image
	 * @param	inactive Inactive state image
	 * @param	textProperties Additional arguements defining the text on this button
	 */
	public function new(?normal:SkinImage, ?moused:SkinImage, ?pressed:SkinImage, ?inactive:SkinImage, ?textProperties:LabelOptions)
	{
		super(textProperties);

		this.normal = normal;
		this.moused = moused;
		this.pressed = pressed;
		this.inactive = inactive;
	}
}
