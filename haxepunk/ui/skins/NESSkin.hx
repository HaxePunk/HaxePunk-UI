package haxepunk.ui.skins;

import flash.display.BitmapData;
import openfl.Assets;
import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.RenderMode;
import com.haxepunk.graphics.atlas.AtlasData;

class NESSkin extends Default
{
	/**
	 * The asset to use for the skin image.
	 */
	static inline var img = "skins/nes.png";

	/**
	 * Returns the portion of the skin image requested as a BitmapData object
	 * @param	x X-Coordinate for the image offset
	 * @param	y Y-Coordinate for the image offset
	 * @param	w Width of the image sub-section
	 * @param	h Height of the image sub-section
	 * @return BitmapData for the image sub-section requested
	 */
	override function gi(x:Int, y:Int, w:Int = 20, h:Int = 20):ImageType
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
}
