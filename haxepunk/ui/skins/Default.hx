package haxepunk.ui.skins;

import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.text.TextFormatAlign;
import openfl.Assets;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.RenderMode;
import com.haxepunk.graphics.atlas.AtlasData;
import haxepunk.ui.skin.Skin;
import haxepunk.ui.skin.SkinButtonElement;
import haxepunk.ui.skin.SkinHasLabelElement;
import haxepunk.ui.skin.SkinImage;
import haxepunk.ui.skin.SkinLabelElement;
import haxepunk.ui.skin.SkinToggleButtonElement;
import haxepunk.ui.skin.SkinWindowElement;

/**
 * HaxePunk-UI default skin definition
 */
class Default extends Skin
{
	/**
	 * The asset to use for the skin image.
	 */
	static inline var img = "skins/default.png";

	public function new()
	{
		super();

		button = new SkinButtonElement(gy(0, 96), gy(24, 96), gy(48, 96), gy(96, 96), {
			color:0x000000,
			size:16,
			align:TextFormatAlign.CENTER,
		});
		toggleButton = new SkinToggleButtonElement(gy(0, 96), gy(24, 96), gy(48, 96), gy(96, 96), gy(48, 96), gy(48, 96), gy(48, 96), gy(20, 20), {
			color:0x000000,
			size:16,
			align:TextFormatAlign.CENTER,
		});
		radioButton = new SkinToggleButtonElement(gy(0, 48, 16, 16), gy(16, 48, 16, 16), gy(32, 48, 16, 16), gy(96, 0, 16, 16), gy(32, 48, 16, 16), gy(48, 48, 16, 16), gy(0, 48, 16, 16), gy(96, 16, 16, 16), {
			color:0x000000,
			size:16,
			x:22,
		});

		label = new SkinHasLabelElement({
			color:0x000000,
			size:16,
		});
		textArea = new SkinLabelElement({
			color:0x000000,
			size:16,
			x:4,
		}, gy(0, 0, 48, 48));
		textField = new SkinLabelElement({
			color:0x000000,
			size:16,
			x:4,
		}, gy(0, 0, 48, 48));
		passwordField = new SkinLabelElement({
			color:0x000000,
			size:16,
			x:4,
		}, gy(0, 0, 48, 48));

		window = new SkinWindowElement(gy(112, 0, 16, 96), gy(48, 0, 96, 96), {
			color:0x000000,
			size:16,
			x:3,
			y:1,
		});
	}

	/**
	 * Returns the portion of the skin image as a SkinImage object in a 9-Slice format
	 * @param	x X-Coordinate for the image offset
	 * @param	y Y-Coordinate for the image offset
	 * @param	w Width of the image sub-section
	 * @param	h Height of the image sub-section
	 * @return SkinImage for the image sub-section requested in 9-Slice format
	 */
	function gy(x:Int, y:Int, w:Int = 24, h:Int = 24):SkinImage
	{
		return new SkinImage(gi(x, y, w, h), true, 4, 4, 4, 4);
	}

	/**
	 * Returns the portion of the skin image as a SkinImage object in a non 9-Sliced format
	 * @param	x X-Coordinate for the image offset
	 * @param	y Y-Coordinate for the image offset
	 * @param	w Width of the image sub-section
	 * @param	h Height of the image sub-section
	 * @return SkinImage for the image sub-section requested in a non 9-Sliced format
	 */
	function gn(x:Int, y:Int, w:Int = 24, h:Int = 24):SkinImage
	{
		return new SkinImage(gi(x, y, w, h), false);
	}

	/**
	 * Returns the portion of the skin image requested as a BitmapData object
	 * @param	x X-Coordinate for the image offset
	 * @param	y Y-Coordinate for the image offset
	 * @param	w Width of the image sub-section
	 * @param	h Height of the image sub-section
	 * @return BitmapData for the image sub-section requested
	 */
	function gi(x:Int, y:Int, w:Int = 20, h:Int = 20):ImageType
	{
		_r.x = x;
		_r.y = y;
		_r.width = w;
		_r.height = h;

		if (HXP.renderMode == RenderMode.BUFFER)
		{
			var b:BitmapData = new BitmapData(w, h, true, 0);
			b.copyPixels(Assets.getBitmapData(img), _r, HXP.zero, null, null, true);
			return b;
		}
		else
		{
			return AtlasData.getAtlasDataByName(img, true).createRegion(_r);
		}
	}

	var _r:Rectangle = new Rectangle();
}
