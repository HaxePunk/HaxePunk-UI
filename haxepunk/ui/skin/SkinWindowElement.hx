package haxepunk.ui.skin;

import haxepunk.graphics.Text;

/**
 * Base class used to create a custom window skin
 */
class SkinWindowElement extends SkinHasLabelElement
{
	/**
	 * Image used for the windows scroll bar
	 */
	public var bar:SkinImage;
	/**
	 * Image used for the body
	 */
	public var body:SkinImage;

	/**
	 * Constructor.
	 * @param	bar Image for scroll bar
	 * @param	body Image for the body
	 * @param	labelProperties optional properties for the text in this element
	 */
	public function new(?bar:SkinImage, ?body:SkinImage, ?labelProperties:LabelOptions)
	{
		super(labelProperties);

		this.bar = bar;
		this.body = body;
	}
}
