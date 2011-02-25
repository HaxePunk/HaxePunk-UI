package com.haxepunk.ui;

import com.haxepunk.utils.Input;

class ToggleButton extends Button
{
	
	public function new(x:Float = 0, y:Float = 0, text:String = "Toggle", width:Int = 0, height:Int = 0, checked:Bool = false, active:Bool = true)
	{
		super(x, y, text, width, height, active);
		_checked = checked;
	}
	
	override public function update()
	{
		if (graphic == inactive) return;
		
		if (_checked)
			graphic = down;
		else
			graphic = normal;
			
		if (collidePoint(x, y, Input.mouseX, Input.mouseY))
		{
			if (Input.mousePressed)
			{
				_checked = !_checked;
			}
			else if (!_checked)
			{
				graphic = hover;
				
				if(!_overCalled)
				{
					if(onHover != null) onHover();
					_overCalled = true;
				}
			}
		}
		else
		{
			_overCalled = false;
		}
	}
	
	public var checked(getChecked, null):Bool;
	private function getChecked():Bool { return _checked; }
	
	private var _checked:Bool;
	
}