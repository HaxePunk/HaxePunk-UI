package haxepunk.ui;

@:enum
abstract ButtonState(Int) from Int to Int
{
	var Normal:Int = 0;
	var Hover:Int = 1;
	var Pressed:Int = 2;
}
