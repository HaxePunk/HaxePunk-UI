package haxepunk.ui.layout;

import flash.geom.Point;

abstract AnchorType(Float)
{
	public static var Left = 0;
	public static var Right = 1;
	public static var Top = 0;
	public static var Bottom = 1;
	public static var Center = 0.5;
}

interface ILayout
{
	public var layoutData:Layout;
	public function layoutChildren(?x:Float, ?y:Float, ?parentWidth:Float, ?parentHeight:Float):Void;
}

/**
 * Data used to position an entity.
 */
class Layout
{
	public var parent:Null<ILayout>;

	public var anchorX:Float = 0;
	public var anchorY:Float = 0;
	public var edgeX:Float = 0;
	public var edgeY:Float = 0;
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;

	public function new() {}

	/**
	 * Set the X position.
	 * @param	anchor	Relative position on screen.
	 * 					0 to 1, 0 = left, 1 = right
	 * @param	edge	The edge of the entity to position at the anchor.
	 * 					0 to 1, 0 = left edge, 1 = right edge
	 */
	public inline function setX(anchor:Float=0, edge:Float=0):Void
	{
		this.anchorX = anchor;
		this.edgeX = edge;
	}

	/**
	 * Set the Y position.
	 * @param	anchor	Relative position on screen.
	 * 					0 to 1, 0 = top, 1 = bottom
	 * @param	edge	The edge of the entity to position at the anchor.
	 * 					0 to 1, 0 = top edge, 1 = bottom edge
	 */
	public inline function setY(anchor:Float=0, edge:Float=0):Void
	{
		this.anchorY = anchor;
		this.edgeY = edge;
	}

	public inline function getXOffset(size:Float, parentSize:Float):Float
	{
		return anchorX * parentSize - size * edgeX + offsetX;
	}

	public inline function getYOffset(size:Float, parentSize:Float):Float
	{
		return anchorY * parentSize - size * edgeY + offsetY;
	}
}
