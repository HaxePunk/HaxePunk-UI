package haxepunk.ui.skin;

import haxepunk.graphics.Text;

/**
 * Base class for every skin element that has a label
 */
class SkinHasLabelElement extends SkinElement
{
	/**
	 * Contains properties defining the label
	 */
	public var labelProperties:Dynamic;

	/**
	 * Constructor.
	 * @param	labelProperties optional properties for a label
	 */
	public function new(?labelProperties:LabelOptions)
	{
		super();
		this.labelProperties = labelProperties;
	}
}
