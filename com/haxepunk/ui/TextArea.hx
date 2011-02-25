package com.haxepunk.ui;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Stamp;
import flash.geom.Rectangle;
import flash.text.TextFieldType;

import com.haxepunk.HXP;

/**
 * @author PigMess
 */

class TextArea extends Label
{
	public function new(x:Float = 0, y:Float = 0, width:Int = 0, height:Int = 0)
	{
		super("", x, y, width, height);
		
		_textField.type = TextFieldType.INPUT;
		_textField.useRichTextClipboard = false;
		_textField.mouseEnabled = true;
		_textField.mouseWheelEnabled = true;
		_textField.selectable = true;
		
		// Add a background so we can see the input area
		graphic = new NineSlice(width, height, new Rectangle(48, 0, 16, 16));
	}
	
	override public function added()
	{
		super.added();
		HXP.stage.addChild(_textField);
	}
	
	override public function removed()
	{
		super.removed();
		HXP.stage.removeChild(_textField);
	}
}