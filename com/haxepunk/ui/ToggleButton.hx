package com.haxepunk.ui;

import com.haxepunk.Graphic;
import com.haxepunk.utils.Input;
import flash.geom.Rectangle;

class ToggleButton extends Button
{
	
	public var hoverDown:Graphic;
	public var inactiveDown:Graphic;
	
	public function new(x:Float = 0, y:Float = 0, text:String = "Toggle", width:Int = 0, height:Int = 0, checked:Bool = false, active:Bool = true)
	{
		super(x, y, text, width, height, active);
		hoverDown = down;
		inactiveDown = new NineSlice(this.width, this.height, new Rectangle(72, 96, 8, 8));
		this.checked = checked;
	}
	
	override public function update()
	{
		if (!_active)
		{
			if (checked)
				graphic = inactiveDown;
			else
				graphic = inactive;
			return;
		}
			
		if (collidePoint(x, y, Input.mouseX, Input.mouseY))
		{
			if (Input.mousePressed)
			{
				checked = !checked;
			}
			else
			{
				if (_checked)
					graphic = hoverDown;
				else
					graphic = hover;
				
				if(!_overCalled)
				{
					if(onHover != null) onHover(this);
					_overCalled = true;
				}
			}
		}
		else
		{
			_overCalled = false;
			if (_checked)
				graphic = down;
			else
				graphic = normal;
		}
	}
	
	public var checked(getChecked, setChecked):Bool;
	private function getChecked():Bool { return _checked; }
	private function setChecked(value:Bool):Bool {
		_checked = value;
		return _checked;
	}
	
	private var _checked:Bool;
	
}