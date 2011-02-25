package com.haxepunk.ui;

import com.haxepunk.Entity;
import flash.display.BitmapData;

/**
 * @author PigMess
 * @author AClockWorkLemon
 * @author Rolpege
 */

class DefaultSkin extends BitmapData { }

class Control extends Entity
{
	
	public static var defaultSkin:BitmapData = new DefaultSkin(0, 0);
	
	/** class constructor
	 * @param x - position of the component on the X axis
	 * @param y - position of the component on the Y axis
	 * @param width - width of the component
	 * @param height - height of the component
	 */
	public function new(x:Float = 0, y:Float = 0, width:Int = 1, height:Int = 1, ?skin:BitmapData) {
		super(x, y);
		this.width = width;
		this.height = height;
		_skin = (skin != null) ? skin : defaultSkin;
	}
	
	private var _skin:BitmapData;
}