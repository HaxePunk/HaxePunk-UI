package haxepunk.ui.layout;

typedef BoundsData =
{
	var min:Null<Float>;
	var max:Null<Float>;
}

@:expose(x, y)
abstract Bounds(BoundsData)
{
	public inline function new(?min:Float, ?max:Float)
	{
		this = {min:min, max:max};
	}

	public inline function clamp(value:Float):Float
	{
		if (this.min != null && value < this.min) value = this.min;
		if (this.max != null && value > this.max) value = this.max;
		return value;
	}

	public inline function iclamp(value:Float):Int return Std.int(clamp(value));
}
