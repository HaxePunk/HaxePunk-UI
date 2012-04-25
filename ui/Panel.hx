package com.haxepunk.ui;

import flash.geom.Point;
import flash.display.BitmapData;
import flash.geom.Rectangle;
import com.haxepunk.Graphic;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

/**
 * @author	AClockWorkLemon (Saxon Landers)
 * 			contact at info.clockworkgames@gmail.com
 */
class Panel extends Control
{
	
	private var children:Array<Control>;
	
	private var oldX:Float;
	private var oldY:Float;
	private var oldWidth:Float;
	private var oldHeight:Float;
	
	/**
	 * A panel to hold components
	 * @param	x		x position of the element on screen
	 * @param	y		y position of the element on screen
	 * @param	width	width of the element
	 * @param	height	height of the element
	 * @param	skin	if specified, sets a custom skin of this object
	 */
	public function new(x:Float = 0, y:Float = 0, width:Int = 48, height:Int = 48, ?skin:BitmapData)
	{
		children = new Array<Control>();
		
		super(x, y, width, height, skin);
		graphic = new NineSlice(width, height, new Rectangle(48, 0, 16, 16), _skin);
		
		oldX = x;
		oldY = y;
		oldWidth = width;
		oldHeight = height;
	}
	
	override public function update() 
	{
		if (width != oldWidth)
		{
			oldWidth = width;
		}
		if (height != oldHeight)
		{
			oldHeight = height;
		}
	}
	
	/**
	 * Adds an Entity to the PunkPanel
	 * @param	toAdd		The object to add
	 * @param	x			The x Position to place the object RELATIVE to the Panel's x Position
	 * @param	y			The y Position to place the object RELATIVE to the Panel's y Position
	 * @param	layer		The z depth of the object. (The lower, the closer to the top)
	 * @return				A reference to the Entity
	 */
	public function add(control:Control, x:Float = 0, y:Float = 0, layer:Int = 0):Control
	{
		control.x += this.x + x;
		control.y += this.y + y;
		
		control.layer = this.layer - layer;
		children.push(control);
		
		if (this.world == HXP.world) { HXP.world.add(control); }
		
		return control;
	}
	
	/**
	 * Removes an object from the PunkPanel
	 * @param	toRemove	The Entity to remove
	 */
	public function remove(control:Control)
	{
		var i:Int;
		for (i in 0...children.length)
		{
			if (children[i] == control)
			{
				if (HXP.world == control.world)
				{
					HXP.world.remove(control);
				}
				children.splice(i, 1);
			}
		}
	}
	
	override public function added() 
	{
		var child:Entity;
		for (child in children) { HXP.world.add(child); }
	}
	
	override public function removed() 
	{
		var child:Entity;
		for (child in children)
		{
			if (HXP.world == child.world)
			{
				HXP.world.remove(child);
			}
		}
	}
	
	//Helper functions
	
	/**
	 * Move children on the x-axis
	 * @param	value the position to move to
	 * @return	the final position
	 */
	override private function setX(value:Float):Float {
		var delta:Float = value - _x;
		for (child in children)
		{
			child.setX(child.x + delta);
		}
		_x = value;
		return _x;
	}
	
	/**
	 * Move children on the y-axis
	 * @param	value	the position to move to
	 * @return	the final position
	 */
	override private function setY(value:Float):Float {
		var delta:Float = value - _y;
		for (child in children)
		{
			child.setY(child.y + delta);
		}
		_y = value;
		return _y;
	}
	
	/**
	 * Please make sure to read this documentation in full.
	 * Setting this to a number will edit the x of the panel.
	 * Setting it to an object will change child x values.
	 * To set it to an object, make it equal { add key/var pairs here }
	 * keys:
	 * 		child:	The entity to check/set. if none is specified, reads/checks the panel.
	 * 		x:	Number to set the child's x to
	 * 		get:	Pass a Number variable to this for it to set it to the specified child's x value.
	 */
	public var relativeX(null, setRelativeX):Dynamic;
	private function setRelativeX(value:Dynamic):Dynamic
	{
		if (Std.is(value, Float))
		{
			// set this object's x
			_x = cast(value, Float);
		}
		else
		{
			// inline getter
			if (Reflect.hasField(value, "get"))
			{
				if (Reflect.hasField(value, "child"))
				{
					var index:Int = Lambda.indexOf(children, value.child);
					if (index < 0)
					{
						throw "Specified child not found on this panel object";
					}
					value.get = cast(children[index].x, Float);
					return value;
				}
				
				trace("2:A child was not specified. No action taken");
				return value;
			}
			
			
			// ensure the x property exists
			if (!Reflect.hasField(value, "x"))
			{
				throw "Missing x property in layer configuration object!";
			}
			
			// changing a child x?
			if (Reflect.hasField(value, "child"))
			{
				var childIndex:Int = Lambda.indexOf(children, value.child);
				if (childIndex < 0)
				{
					throw "specified child not found on this panel object";
				}
				children[childIndex].x = this.x + value.x;
				return value;
			}
			
			trace("2:A child was not specified. No action taken");
		}
		return value;
	}
	
	/**
	 * Please make sure to read this documentation in full.
	 * Setting this to a number will edit the y of the panel.
	 * Setting it to an object will change child y values.
	 * To set it to an object, make it equal { add key/var pairs here }
	 * keys:
	 * 		child:	The entity to check/set. if none is specified, reads/checks the panel.
	 * 		y:	Number to set the child's y to
	 * 		get:	Pass a Number variable to this for it to set it to the specified child's x value.
	 */
	public var relativeY(null, setRelativeY):Dynamic;
	private function setRelativeY(value:Dynamic):Dynamic
	{
		if (Std.is(value, Float))
		{
			// set this object's y
			_y = cast(value, Float);
		}
		else
		{
			// inline getter
			if (Reflect.hasField(value, "get"))
			{
				if (Reflect.hasField(value, "child"))
				{
					var index:Int = Lambda.indexOf(children, value.child);
					if (index < 0)
					{
						throw "Specified child not found on this panel object";
					}
					value.get = cast(children[index].y, Float);
					return value;
				}
				
				trace("2:A child was not specified. No action taken");
				return value;
			}
			
			
			// ensure the y property exists
			if (!Reflect.hasField(value, "y"))
			{
				throw "Missing y property in layer configuration object!";
			}
			
			// changing a child y?
			if (Reflect.hasField(value, "child"))
			{
				var childIndex:Int = Lambda.indexOf(children, value.child);
				if (childIndex < 0)
				{
					throw "specified child not found on this panel object";
				}
				children[childIndex].y = y + value.y;
				return value;
			}
			
			trace("2:A child was not specified. No action taken");
		}
		return value;
	}
	
	
	
	/**
	 * Please make sure to read this documentation in full.
	 * Setting this to a number will edit the layer of the panel.
	 * Setting it to an object will change child layers.
	 * To set it to an object, make it equal { add key/var pairs here }
	 * keys:
	 * 		child:	The entity to check/set. if none is specified, reads/checks the panel.
	 * 		layer:	Number to set the child's layer to
	 * 		get:	Pass a Number variable to this for it to set it to the specified child's layer.
	 */
	public var Layer(null, setLayer2):Dynamic;
	private function setLayer2(value:Dynamic):Dynamic
	{
		if (Std.is(value, Float))
		{
			// set this object's layer
			this.layer = Std.int(value);
		}
		else
		{
			// inline getter
			if (value.hasOwnProperty("get"))
			{
				if (value.hasOwnProperty("child"))
				{
					var index:Int = Lambda.indexOf(children, value.child);
					if (index < 0)
					{
						throw "specified child not found on this panel object";
					}
					value.get = children[index].layer;
					return;
				}
				
				trace("2:A child was not specified. No action taken");
				return;
			}
			
			
			// ensure the layer property exists
			if (!value.hasOwnProperty("layer"))
			{
				throw "Missing layer property in layer configuration object!";
			}
			
			// changing a child layer?
			if (value.hasOwnProperty("child"))
			{
				var childIndex:Int = Lambda.indexOf(children, value.child);
				if (childIndex < 0)
				{
					throw "specified child not found on this panel object";
				}
				children[childIndex].layer = Std.int(Layer - value.layer);
				return;
			}
			
			trace("2:A child was not specified. No action taken");
		}
	}
	
	/**
	 * Hides specified objects in the panel
	 * @param	...objs		Objects to hide
	 */
	public var hide(getHide, null):Dynamic;
	private function getHide():Dynamic
	{
		var me = this;
		return Reflect.makeVarArgs(function (objs:Array<Dynamic>):Dynamic
		{
			var i:Int;
			for (i in 0...objs.length)
			{
				var index:Int = Lambda.indexOf(me.children, objs[i]);
				if (index < 0)
				{
					throw "Child '" + objs[i] + "'not found in panel.";
				}
				me.children[index].visible = false;
			}
		});
	}
	
	/**
	 * Shows specified objects in the panel
	 * @param	...objs		Objects to show
	 */
	public var show(getShow, null):Dynamic;
	private function getShow():Dynamic
	{
		var me = this;
		return Reflect.makeVarArgs(function (objs:Array<Dynamic>):Dynamic
		{
			var i:Int;
			for (i in 0...objs.length)
			{
				var index:Int = Lambda.indexOf(me.children, objs[i]);
				if (index < 0)
				{
					throw "Child '" + objs[i] + "'not found in panel.";
				}
				me.children[index].visible = true;
			}
		});
	}
}