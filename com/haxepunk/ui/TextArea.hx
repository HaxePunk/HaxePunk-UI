package com.haxepunk.ui;

import com.haxepunk.graphics.Graphiclist;
import com.haxepunk.graphics.Stamp;
import flash.geom.Rectangle;
import flash.text.TextFieldType;
import flash.text.TextFormatAlign;

import com.haxepunk.HXP;

/**
 * @author PigMess
 */

class TextArea extends Label
{
	
	public var padding:Int;
	
	public function new(x:Float = 0, y:Float = 0, width:Int = 1, height:Int = 1)
	{
		super("Name", x, y, width, height, TextFormatAlign.LEFT);
		padding = 4;
		
		_textField.type = TextFieldType.INPUT;
		_textField.useRichTextClipboard = false;
		_textField.mouseEnabled = true;
		_textField.mouseWheelEnabled = true;
		_textField.selectable = true;
		_textField.multiline = true;
		_textField.wordWrap = true;
		
		// Add a background so we can see the input area
		graphic = new NineSlice(this.width, this.height, new Rectangle(0, 0, 16, 16));
	}
	
	override private function setX(value:Float):Float
	{
		_textField.x = value + padding;
		return super.setX(value);
	}
	
	override private function setY(value:Float):Float
	{
		_textField.y = value + padding;
		return super.setY(value);
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