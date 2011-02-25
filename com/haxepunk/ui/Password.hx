package com.haxepunk.ui;

/**
 * @author PigMess
 */

class Password extends TextField
{
	public function new(x:Float = 0, y:Float = 0, width:Int = 1, height:Int = 1)
	{
		super(x, y, width, height);
		
		_textField.displayAsPassword = true;
	}
}
