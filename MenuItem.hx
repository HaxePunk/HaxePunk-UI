package com.haxepunk.ui;

class MenuItem extends Button
{
	
	public function new(text:String, click:Dynamic)
	{
		super(x, y, text, 0, 0, true);
		onClick = click;
	}
	
}