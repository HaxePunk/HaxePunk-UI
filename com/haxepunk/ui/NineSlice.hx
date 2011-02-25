package com.haxepunk.ui;

import com.haxepunk.Graphic;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

/**
 * ...
 * @author AClockWorkLemon
 */
class NineSlice extends Graphic
{
	private var _skin:BitmapData;
	
	private var _topLeft:Image;
	private var _topCenter:Image;
	private var _topRight:Image;
	private var _centerLeft:Image;
	private var _centerCenter:Image;
	private var _centerRight:Image;
	private var _bottomLeft:Image;
	private var _bottomCenter:Image;
	private var _bottomRight:Image;
	
	private var _xScale:Float;
	private var _yScale:Float;
	
	private var _clipRect:Rectangle;
	
	private var width:Float;
	private var height:Float;
	
	/**
	 * Constructor. Initiates the class
	 * @param	width		Initial Width of the 9slice
	 * @param	height		Initial Height of the 9slice
	 * @param	clipRect	Rectangle of the area on the skin to use
	 * @param	gridSize	Grid spacing to use when chopping
	 * @param	skin		optional custom skin
	 */
	public function new(width:Float, height:Float, ?clipRect:Rectangle, ?skin:BitmapData)
	{
		super();
		_skin = (skin != null) ? skin : Control.defaultSkin;
		this.width = width;
		this.height = height;
		
		if (clipRect == null) clipRect = new Rectangle(0, 0, 1, 1);
		_clipRect = clipRect;
		
		_topLeft      = new Image(_skin, new Rectangle(clipRect.x                     , clipRect.y                      , clipRect.width, clipRect.height));
		_topCenter    = new Image(_skin, new Rectangle(clipRect.x + clipRect.width    , clipRect.y                      , clipRect.width, clipRect.height));
		_topRight     = new Image(_skin, new Rectangle(clipRect.x + clipRect.width * 2, clipRect.y                      , clipRect.width, clipRect.height));
		_centerLeft   = new Image(_skin, new Rectangle(clipRect.x                     , clipRect.y + clipRect.height    , clipRect.width, clipRect.height));
		_centerCenter = new Image(_skin, new Rectangle(clipRect.x + clipRect.width    , clipRect.y + clipRect.height    , clipRect.width, clipRect.height));
		_centerRight  = new Image(_skin, new Rectangle(clipRect.x + clipRect.width * 2, clipRect.y + clipRect.height    , clipRect.width, clipRect.height));
		_bottomLeft   = new Image(_skin, new Rectangle(clipRect.x                     , clipRect.y + clipRect.height * 2, clipRect.width, clipRect.height));
		_bottomCenter = new Image(_skin, new Rectangle(clipRect.x + clipRect.width    , clipRect.y + clipRect.height * 2, clipRect.width, clipRect.height));
		_bottomRight  = new Image(_skin, new Rectangle(clipRect.x + clipRect.width * 2, clipRect.y + clipRect.height * 2, clipRect.width, clipRect.height));
	}
	
	/**
	 * Updates the Image. Make sure to set graphic = output image afterwards.
	 * @param	width	New width
	 * @param	height	New height
	 * @return
	 */
	override public function render(target:BitmapData, point:Point, camera:Point)
	{
		if (width  < _clipRect.width * 2)  width  = _clipRect.width * 2;
		if (height < _clipRect.height * 2) height = _clipRect.height * 2;
		
		_xScale = (width - _clipRect.width * 2) / _clipRect.width;
		_yScale = (height - _clipRect.height * 2) / _clipRect.height;
		
		_topCenter.scaleX = _xScale;
		_centerLeft.scaleY = _yScale;
		_centerCenter.scaleX = _xScale;
		_centerCenter.scaleY = _yScale;
		_centerRight.scaleY = _yScale;
		_bottomCenter.scaleX = _xScale;
		
		// half
		var hw = _clipRect.width / 2;
		var hh = _clipRect.height / 2;
		// half-scaled
		var hsw = (_clipRect.width + (_xScale * _clipRect.width)) / 2;
		var hsh = (_clipRect.height + (_yScale * _clipRect.height)) / 2;
		
		_topCenter.x    = hw;
		_topRight.x     = hsw;
		_centerLeft.y   = hh;
		_centerCenter.x = hw;
		_centerCenter.y = hh;
		_centerRight.x  = hsw;
		_centerRight.y  = hh;
		_bottomLeft.y   = hsh;
		_bottomCenter.x = hw;
		_bottomCenter.y = hsh;
		_bottomRight.x  = hsw;
		_bottomRight.y  = hsh;
		
		_topLeft.render(target, new Point(_topLeft.x + point.x, _topLeft.y + point.y), camera);
		_topCenter.render(target, new Point(_topCenter.x + point.x, _topCenter.y + point.y), camera);
		_topRight.render(target, new Point(_topRight.x + point.x, _topRight.y + point.y), camera);
		_centerLeft.render(target, new Point(_centerLeft.x + point.x, _centerLeft.y + point.y), camera);
		_centerCenter.render(target, new Point(_centerCenter.x + point.x, _centerCenter.y + point.y), camera);
		_centerRight.render(target, new Point(_centerRight.x + point.x, _centerRight.y + point.y), camera);
		_bottomLeft.render(target, new Point(_bottomLeft.x + point.x, _bottomLeft.y + point.y), camera);
		_bottomCenter.render(target, new Point(_bottomCenter.x + point.x, _bottomCenter.y + point.y), camera);
		_bottomRight.render(target, new Point(_bottomRight.x + point.x, _bottomRight.y + point.y), camera);
	}
	
}