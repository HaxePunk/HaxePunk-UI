package haxepunk.ui.skin;

import haxepunk.graphics.Text;

/**
 * Base class to used to create a custom Label with background skin
 */
class SkinLabelElement extends SkinHasLabelElement
{
	/**
	 * background image for the label
	 */
	public var background:SkinImage;

	/**
	 * Constructor
	 * @param	labelProperties optional properties for a label
	 * @param	background background image
	 */
	public function new(?labelProperties:LabelOptions, ?background:SkinImage)
	{
		super(labelProperties);

		this.background = background;
	}
}
