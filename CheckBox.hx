package com.haxepunk.ui;

import com.haxepunk.graphics.Image;
import flash.geom.Rectangle;
import flash.text.TextFormatAlign;

class CheckBox extends ToggleButton
{
	
	public function new(x:Float = 0, y:Float = 0, text:String = "Checkbox", checked:Bool = false, width:Int = 100, active:Bool = true)
	{
		_align = TextFormatAlign.LEFT;
		super(x, y, text, width, 0, checked, active);
		this.width = this.height = 16;
		
		normal = new Image(_skin, new Rectangle(0, 48, 16, 16));
		hover = new Image(_skin, new Rectangle(16, 48, 16, 16));
		down = new Image(_skin, new Rectangle(64, 48, 16, 16));
		hoverDown = new Image(_skin, new Rectangle(80, 48, 16, 16));
		inactive = new Image(_skin, new Rectangle(96, 0, 16, 16));
		inactiveDown = new Image(_skin, new Rectangle(96, 32, 16, 16));
	}
	
	override private function setX(value:Float):Float
	{
		label.x = value + width + padding;
		_x = value;
		return _x;
	}
	
}