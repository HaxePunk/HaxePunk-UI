package haxepunk.ui;

import haxepunk.ui.UIComponent;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import com.haxepunk.HXP;
import com.haxepunk.Graphic;
import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.tweens.misc.MultiVarTween;
import com.haxepunk.utils.Ease;

import haxepunk.ui.skin.Skin;

/**
 * A panel component. This component can contain other UIComponents.
 */
class Panel extends UIComponent
{
	public var children(get, never):Array<UIComponent>;
	public var count(get, never):Int;
	var mouseX(get, never):Int;
	var mouseY(get, never):Int;

	/**
	 * A graphic list which can be used to add graphical components to the panel.
	 */
	public var graphiclist:Graphiclist;

	/**
	 * Render buffer for this component
	 */
	var buffer:BitmapData;
	/**
	 * Pointer to the clipping mask used in the rendering process
	 */
	var bounds:Rectangle;

	/**
	 * Container for all child elements of the panel
	 */
	var _children:Array<UIComponent> = new Array<UIComponent>();
	/**
	 * Count of child elements
	 */
	var _count:Int = 0;

	/**
	 * Stores the previous X-Coordinate for use when updating positions of child components.
	 */
	var oldX:Float = 0;
	/**
	 * Stores the previous Y-Coordinate for use when updating the positions of child components.
	 */
	var oldY:Float = 0;

	/**
	 * Stores the previous X-Scroll offset for use when updating the position of child components.
	 */
	var _oldScrollX:Float = 0;
	/**
	 * Stores the previous Y-Scroll offset for use when updating the position of child components.
	 */
	var _oldScrollY:Float = 0;

	/**
	 * Target distance in the X plane to scroll the panel
	 */
	var _targetX:Float = 0;
	/**
	 * Target distance in the Y-plane to scroll the panel.
	 */
	var _targetY:Float = 0;

	/**
	 * Easing amount used in scrolling
	 */
	var _t:Float = 0;

	/**
	 * X-Scroll offset
	 */
	public var scrollX:Float = 0;
	/**
	 * Y-Scroll offset
	 */
	public var scrollY:Float = 0;

	/**
	 * Constructor.
	 * @param	x X-Coordinate for the component
	 * @param	y Y-Coordinate for the component
	 * @param	width Width of the component
	 * @param	height Height of the component
	 * @param	skin Skin to use when rendering the component
	 */
	public function new(x:Float = 0, y:Float = 0, width:Int = 20, height:Int = 20, skin:Skin = null)
	{
		if (width < 1) width = 1;
		if (height < 1) height = 1;

		super(x, y, width, height, skin);

		oldX = x;
		oldY = y;

		buffer = new BitmapData(HXP.width, HXP.height, true, 0x00000000);
		bounds = new Rectangle(0, 0, width, height);

		graphic = graphiclist = new Graphiclist();
	}

	/**
	 * Add a UIComponent to the panel.
	 * @param	uiComponent Punk UI component to add
	 * @return  UIComponent that was added
	 */
	public function add(uiComponent:UIComponent):UIComponent
	{
		if (Std.is(uiComponent, Panel))
		{
			trace("Panels can't contain other Panels at the moment.");
			return uiComponent;
		}

		if (uiComponent._panel != null) return uiComponent;
		_children[_count++] = uiComponent;
		uiComponent._panel = this;
		uiComponent.x += x + scrollX;
		uiComponent.y += y + scrollY;
		uiComponent.added();
		return uiComponent;
	}

	/**
	 * Remove a UIComponent from the panel.
	 * @param	uiComponent UIComponent to remove
	 * @return  the UIComponent that was removed
	 */
	public function remove(uiComponent:UIComponent):UIComponent
	{
		var index:Int = Lambda.indexOf(_children, uiComponent);
		if (index < 0) return uiComponent;
		_children.splice(index, 1);
		uiComponent.renderTarget = null;
		uiComponent.removed();
		uiComponent._panel = null;
		return uiComponent;
	}

	override public function update():Void
	{
		super.update();

		var uiComponent:UIComponent;
		for (uiComponent in _children)
		{
			if (!uiComponent.active)     continue;

			uiComponent.updateTweens();
			uiComponent.update();
			if (uiComponent.graphic != null && uiComponent.graphic.active)
			{
				uiComponent.graphic.update();
			}
		}

		if (_targetX != scrollX || _targetY != scrollY)
		{
			if (_scrolledWithEase)
			{
				var d:Float = HXP.distance(_targetX, _targetY, scrollX, scrollY);
				var s:Float = d / _t;

				point.x = _targetX - scrollX;
				point.y = _targetY - scrollY;
				point.normalize(s);
				scrollX += point.x;
				scrollY += point.y;
			}
		}
		else
		{
			_scrolledWithEase = false;
		}

		bounds.width = width;
		bounds.height = height;
	}

	override public function render():Void
	{
		super.render();

		buffer.fillRect(HXP.bounds, 0x00000000);

		if (oldX != x || oldY != y || _oldScrollX != scrollX || _oldScrollY != scrollY)
		{
			for (uiComponent in _children)
			{
				uiComponent.x += (x - oldX) + (scrollX - _oldScrollX);
				uiComponent.y += (y - oldY) + (scrollY - _oldScrollY);
			}

			oldX = x;
			oldY = y;

			_oldScrollX = scrollX;
			_oldScrollY = scrollY;
		}

		for (uiComponent in _children)
		{
			if (!uiComponent.visible) continue;

			if (uiComponent._camera != null)
			{
				uiComponent._camera.x = uiComponent._camera.y = 0;
			}
			else uiComponent._camera = new Point();

			uiComponent.renderTarget = buffer;
			uiComponent.render();
		}

		HXP.point.x = relativeX - HXP.camera.x;
		HXP.point.y = relativeY - HXP.camera.y;

		bounds.x = x;
		bounds.y = y;

		var t:BitmapData = (renderTarget != null) ? renderTarget : HXP.buffer;
		t.copyPixels(buffer, bounds, HXP.point);
	}

	/**
	 * Scroll the panel to a location, with easing.
	 * @param	x X-Coordinate to scroll to
	 * @param	y Y-Coordinate to scroll to
	 * @param	ease Strength of the ease. Set to 1 to disable easing and scroll automatically.
	 */
	public function scrollTo(x:Float, y:Float, ease:Float = 1):Void
	{
		_targetX = x;
		_targetY = y;
		_t = (ease < 1) ? 1:ease;
		_scrolledWithEase = true;
	}

	/**
	 * Add a Graphic to the panel
	 * @param	graphic Graphic to add
	 * @return the Graphic added to the panel
	 */
	override public function addGraphic(graphic:Graphic):Graphic
	{
		return graphiclist.add(graphic);
	}

	/**
	 * Remove a Graphic from the panel
	 * @param	graphic Graphic to remove
	 * @return the Graphic removed from the panel
	 */
	public function removeGraphic(graphic:Graphic):Graphic
	{
		return graphiclist.remove(graphic);
	}

	/**
	 * Return the vector containing all child UIComponents
	 */
	function get_children():Array<UIComponent>
	{
		return _children;
	}

	/**
	 * Count of all child UIComponents in the panel
	 */
	function get_count():Int
	{
		return _count;
	}

	/**
	 * Add a list of UIComponents to the panel
	 * @param	list	the list of UIComponents to add
	 */
	public function addList(list:Array<UIComponent>):Void
	{
		for (e in list) add(e);
	}

	/**
	 * Remove a list of UIComponents from the panel
	 * @param	list	the list of UIComponents to remove
	 */
	public function removeList(list:Array<UIComponent>):Void
	{
		for (e in list) remove(e);
	}

	/**
	 * Remove every UIComponent from the panel
	 */
	public function removeAll():Void
	{
		for (e in children)
		{
			remove(e);
		}
	}

	override public function added():Void
	{
		super.added();

		for (e in children)
		{
			e.added();
		}
	}

	override public function removed():Void
	{
		super.removed();

		for (e in children)
		{
			e.removed();
		}
	}

	function get_mouseX():Int return (_panel != null) ? _panel.mouseX:world.mouseX;
	function get_mouseY():Int return (_panel != null) ? _panel.mouseY : world.mouseY;

	/**
	 * Return the top most UIComponent of the panel at a given point
	 * @param	x X-Coordinate
	 * @param	y Y-Coordinate
	 * @return  top most UIComponent at the supplied point
	 */
	@:allow(haxepunk.ui)
	function frontCollidePoint(x:Float, y:Float):UIComponent
	{
		var i:Int = _children.length - 1;
		var c:UIComponent;
				while (i > -1){
			c = _children[i];
			if (c.collidePoint(c.x, c.y, x, y))     return c;
			--i;
		}
		return null;
	}

	var _scrolledWithEase:Bool = false;

	static var point:Point = new Point();
}
