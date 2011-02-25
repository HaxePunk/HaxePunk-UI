package com.haxepunk.ui;

import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.Mask;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import flash.display.BitmapData;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextFormatAlign;

/**
 * @author Rolpege
 * @coauthor PigMess
 */

class Button extends Control
{	
	/**
	 * This function will be called when the button is pressed. 
	 */		
	public dynamic function onClick(button:Button) { }
	
	/**
	 * This function will be called when the mouse overs the button. 
	 */		
	public dynamic function onHover(button:Button) { }
	
	/**
	 * Graphic of the button when active and not pressed nor overed.
	 */	
	public var normal:Graphic;
	/**
	 * Graphic of the button when the mouse overs it and it's active.
	 */		
	public var hover:Graphic;
	/**
	 * Graphic of the button when the mouse is pressing it and it's active.
	 */		
	public var down:Graphic;
	/**
	 * Graphic of the button when inactive.
	 */
	public var inactive:Graphic;
	
	/**
	 * The button's label 
	 */		
	public var label:Label;
	
	/**
	 * Constructor.
	 *  
	 * @param x			X coordinate of the button.
	 * @param y			Y coordinate of the button.
	 * @param width		Width of the button's hitbox.
	 * @param height	Height of the button's hitbox.
	 * @param text		Text of the button
	 * @param callback	The function that will be called when the button is pressed.
	 * @param active	Whether the button is active or not.
	 */
	public function new(x:Float = 0, y:Float = 0, text:String = "Button", width:Int = 0, height:Int = 0, active:Bool = true)
	{
		_overCalled = false;
		label = new Label(text, x, y, width, height, _align);
		label.color = 0x000000;
		
		padding = 4;
		
		normal = new NineSlice(this.width, this.height, new Rectangle(0, 96, 8, 8));
		hover = new NineSlice(this.width, this.height, new Rectangle(24, 96, 8, 8));
		down = new NineSlice(this.width, this.height, new Rectangle(48, 96, 8, 8));
		inactive = new NineSlice(this.width, this.height, new Rectangle(96, 96, 8, 8));
		
		super(x, y, this.width, this.height);
		setHitbox(this.width, this.height);
		isActive = active; // sets the graphic
	}
	
	/**
	 * Amount to pad between button edge and label
	 */
	public var padding(getPadding, setPadding):Int;
	private function getPadding():Int { return _padding; }
	private function setPadding(value:Int):Int {
		_padding = value;
		width = label.width + _padding * 2;
		height = label.height + _padding * 2;
		return _padding;
	}
	
	public var isActive(getActive, setActive):Bool;
	private function getActive():Bool { return _active; }
	private function setActive(value:Bool):Bool {
		_active = value;
		return _active;
	}
	
	override private function setX(value:Float):Float
	{
		label.x = value + padding;
		return super.setX(value);
	}
	
	override private function setY(value:Float):Float
	{
		label.y = value + halfHeight - label.size + padding;
		return super.setY(value);
	}
	
	/**
	 * @private 
	 */
	override public function update()
	{
		if (_active) {
			super.update();
			
			if(collidePoint(x, y, Input.mouseX, Input.mouseY))
			{
				if(Input.mouseDown)
				{
					graphic = down;
				}
				else
				{
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
				graphic = normal;
				_overCalled = false;
			}
		}
		else
		{
			graphic = inactive;
		}
	}
	
	public function onMouseUp(e:MouseEvent = null)
	{
		if(graphic == inactive || !Input.mouseReleased) return;
		if(collidePoint(x, y, Input.mouseX, Input.mouseY)) onClick(this);
	}
	
	/**
	 * @private
	 */
	override public function added()
	{
		super.added();
		HXP.world.add(label);
		
		if (HXP.stage != null) HXP.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	/**
	 * @private
	 */
	override public function removed()
	{
		super.removed();
		HXP.world.remove(label);
		
		if(HXP.stage != null) HXP.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
	}
	
	/** @private */ private var _overCalled:Bool;
	/** @private */ private var _padding:Int;
	/** @private */ private var _align:TextFormatAlign;
	/** @private */ private var _active:Bool;
}