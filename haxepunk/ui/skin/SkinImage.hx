package haxepunk.ui.skin;

import haxepunk.Graphic;
import haxepunk.graphics.NineSlice;

/**
 * Image wrapper used for skinning Punk.UI components
 */
class SkinImage extends NineSlice
{
	/**
	 * If this image is a 9-Slice image
	 */
	var nineSlice:Bool;

	/**
	 * Constructor.
	 * @param	source Source image
	 * @param	nineSlice If the source image is a 9-Slice image
	 * @param	leftWidth Distance from left side of the source image used for 9-Slicking the image
	 * @param	rightWidth Distance from right side of the source image used for 9-Slicking the image
	 * @param	topHeight Distance from top side of the source image used for 9-Slicking the image
	 * @param	bottomHeight Distance from bottom side of the source image used for 9-Slicking the image
	 */
	public function new(source:ImageType, nineSlice:Bool = true, leftWidth:Int = 0, rightWidth:Int = 0, topHeight:Int = 0, bottomHeight:Int = 0)
	{
		this.nineSlice = nineSlice;
		if (!nineSlice) leftWidth = rightWidth = topHeight = bottomHeight = 0;
		super(source, leftWidth, rightWidth, topHeight, bottomHeight);
	}

	public function clone():SkinImage
	{
		var leftWidth = Std.int(_sliceRect.x),
			rightWidth = Std.int(source.width - _sliceRect.width),
			topHeight = Std.int(_sliceRect.y),
			bottomHeight = Std.int(source.height - _sliceRect.height);
		return new SkinImage(source, nineSlice, leftWidth, rightWidth, topHeight, bottomHeight);
	}
}
