package haxepunk.ui;

import flash.display.BitmapData;
import flash.geom.Point;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import haxepunk.ui.skin.Skin;
import haxepunk.ui.skin.SkinImage;

/**
 * Base class for all Punk.UI components
 */
class UIComponent extends Entity
{
	public static inline var DEFAULT_TYPE:String = "UI";

	public var relativeX(get, set):Float;
	public var relativeY(get, set):Float;

	/**
	 * Constructor
	 * @param	x X-Coordinate to place the component
	 * @param	y Y-Coordinate to place the component
	 * @param	width Width of the component
	 * @param	height Height of the component
	 * @param	skin Skin to style this component with
	 */
	public function new(x:Float = 0, y:Float = 0, width:Int = 1, height:Int = 1, skin:Skin = null)
	{
		super(x, y);
		this.width = width;
		this.height = height;

		var s:Skin = (skin != null) ? skin : UI.skin;
		if (s != null) setupSkin(s);

		type = DEFAULT_TYPE;
	}

	/**
	 * Override this, called by components extending this class to do skin specific setup
	 * @param	skin the PunkSkin to use for custom skin setup
	 */
	function setupSkin(skin:Skin):Void {}

	/**
	 * Returns the FlashPunk Image representation of a SkinImage, cropped to the supplied width and height, if available
	 * @param	skinImage the SkinImage to convert to a FlashPunk Image
	 * @param	width Width of the image section to return
	 * @param	height Height of the image section to return
	 * @return FlashPunk Image copy of the SkinImage or null if no skin image is supplied.
	 */
	function getSkinImage(skinImage:SkinImage, width:Int = 0, height:Int = 0):SkinImage
	{
		var skinImage = skinImage.clone();
		skinImage.width = width;
		skinImage.height = height;
		return skinImage;
	}

	/**
	 * Relative X-Coordinate for the component
	 */
	function get_relativeX():Float
	{
		if (_panel != null) return x - _panel.x - _panel.scrollX;
		return x;
	}

	function get_relativeY():Float
	{
		if (_panel != null) return y - _panel.y - _panel.scrollY;
		return y;
	}

	function set_relativeX(value:Float):Float
	{
		if (_panel != null) x = value + _panel.x + _panel.scrollX
		else x = value;
		return value;
	}

	function set_relativeY(value:Float):Float
	{
		if (_panel != null) y = value + _panel.y + _panel.scrollY
		else y = value;
		return value;
	}

	@:allow(haxepunk.ui)
	var _panel:Panel;
}
