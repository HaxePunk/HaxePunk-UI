package com.haxepunk.ui;

import com.haxepunk.graphics.Image;
import flash.geom.Rectangle;
import flash.text.TextFormatAlign;

class RadioButton extends ToggleButton
{
	
	public function new(x:Float = 0, y:Float = 0, text:String = "Checkbox", id:String = "radio", checked:Bool = false, width:Int = 100, active:Bool = true)
	{
		_align = TextFormatAlign.LEFT;
		_name = id;
		addButton();
		
		super(x, y, text, width, 0, checked, active);
		this.width = this.height = 16;
		
		normal = new Image(_skin, new Rectangle(0, 64, 16, 16));
		hover = new Image(_skin, new Rectangle(16, 64, 16, 16));
		down = new Image(_skin, new Rectangle(32, 64, 16, 16));
		hoverDown = new Image(_skin, new Rectangle(48, 64, 16, 16));
		inactive = new Image(_skin, new Rectangle(64, 64, 16, 16));
		inactiveDown = new Image(_skin, new Rectangle(80, 64, 16, 16));
	}
	
	private function addButton()
	{
		var buttons:Array<RadioButton> = _buttons.get(_name);
		if (buttons == null)
		{
			buttons = new Array<RadioButton>();
			buttons.push(this);
			_buttons.set(_name, buttons);
		}
		else
		{
			buttons.push(this);
		}
	}
	
	override private function setChecked(value:Bool):Bool
	{
		if (value)
		{
			var buttons:Array<RadioButton> = _buttons.get(_name);
			var button:RadioButton;
			for (button in buttons)
			{
				if (button != this)
					button._checked = false;
			}
		}
		return super.setChecked(value);
	}
	
	override private function setX(value:Float):Float
	{
		label.x = value + width + padding;
		_x = value;
		return _x;
	}
	
	private var _name:String;
	private static var _buttons:Hash<Array<RadioButton>> = new Hash<Array<RadioButton>>();
	
}