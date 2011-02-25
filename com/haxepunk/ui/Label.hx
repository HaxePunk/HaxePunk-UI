package com.haxepunk.ui;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormatAlign;
import flash.text.TextFormat;

import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Stamp;

/**
 * @author PigMess
 * @author Rolpege
 */

class Label extends Control
{	
	public static var defaultSize:Float = 16;
	public static var defaultColor:Int = 0xff33cc;
	public static var defaultBackgroundColor:Int = 0x202020;
	public static var defaultBackground:Bool = false;
	
	public function new(text:String = "", x:Float = 0, y:Float = 0, width:Int = 0, height:Int = 0, ?align:TextFormatAlign)
	{
		var format:TextFormat = new TextFormat("default", Label.defaultSize, Label.defaultColor);
		format.align = TextFormatAlign.CENTER;
		if (align != null) format.align = align;
		
		_textField = new TextField();
		_textField.text = text;
		_textField.setTextFormat(format);
		_textField.selectable = false;
		_textField.embedFonts = true;
		if (width != 0) _textField.width = width;
		if (height != 0) _textField.height = height;
		_textField.backgroundColor = Label.defaultBackgroundColor;
		_textField.background = Label.defaultBackground;
		_textField.maxChars = 0;
		_textField.useRichTextClipboard = true;
		_textField.wordWrap = true;
		_textField.multiline = true;
		_textField.x = x;
		_textField.y = y;
		
		if (width == 0) width = Std.int(_textField.textWidth);
		if (height == 0) height = Std.int(_textField.textHeight);
		
		super(x, y, width, height);
		
		_renderRect = new Rectangle(0, 0, _textField.width, _textField.height);
		_textBuffer = new BitmapData(Std.int(_textField.width), Std.int(_textField.height), true, 0x00000000);
		graphic = new Stamp(_textBuffer);
	}
	
	override public function render()
	{
		super.render();
		
		_textBuffer.fillRect(_renderRect, _textField.background ? _textField.backgroundColor : 0x00000000);
		_textBuffer.draw(_textField);
	}
	
	public var text(getText, setText):String;
	private function getText():String { return _textField.text; }
	private function setText(value:String):String {
		_textField.text = value;
		return value;
	}
	
	public var color(getColor, setColor):Int;
	private function getColor():Int { return _textField.textColor; }
	private function setColor(value:Int):Int {
		_textField.textColor = value;
		return value;
	}
	
	public var backgroundColor(getBackgroundColor, setBackgroundColor):Int;
	private function getBackgroundColor():Int { return _textField.backgroundColor; }
	private function setBackgroundColor(value:Int):Int {
		_textField.backgroundColor = value;
		return value;
	}
	
	public var length(getLength, null):Int;
	private function getLength():Int { return _textField.length; }
	
	public var size(getSize, setSize):Dynamic;
	private function getSize():Dynamic { return _textField.defaultTextFormat.size; }
	private function setSize(value:Dynamic):Dynamic {
		_textField.defaultTextFormat.size = value;
		return value;
	}
	
	public var font(getFont, setFont):String;
	private function getFont():String { return _textField.defaultTextFormat.font; }
	private function setFont(value:String):String {
		_textField.defaultTextFormat.font = value;
		return value;
	}
	
	public var background(getBackground, setBackground):Bool;
	private function getBackground():Bool { return _textField.background; }
	private function setBackground(value:Bool):Bool {
		_textField.background = value;
		return value;
	}

	private var _textField:TextField;
	private var _renderRect:Rectangle;
	private var _textBuffer:BitmapData;
}