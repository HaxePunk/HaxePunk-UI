package com.haxepunk.ui;

import com.haxepunk.graphics.Image;
import flash.geom.Rectangle;
import flash.text.TextFormatAlign;

class CheckBox extends ToggleButton
{
	
	public function new(x:Float = 0, y:Float = 0, text:String = "Checkbox", width:Int = 100, checked:Bool = false, active:Bool = true)
	{
		_align = TextFormatAlign.LEFT;
		super(x, y, text, width, 0, checked, active);
		this.width = this.height = 16;
		
		normal = new Image(Control.defaultSkin, new Rectangle(48, 48, 16, 16));
		hover = new Image(Control.defaultSkin, new Rectangle(64, 48, 16, 16));
		down = new Image(Control.defaultSkin, new Rectangle(80, 48, 16, 16));
		// This is the same as normal right now...
		inactive = new Image(Control.defaultSkin, new Rectangle(48, 48, 16, 16));
	}
	
	override private function setX(value:Float):Float
	{
		label.x = value + width;
		_x = value;
		return _x;
	}
	
}