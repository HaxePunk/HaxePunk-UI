package haxepunk.ui;

import flash.text.TextFormatAlign;
import com.haxepunk.graphics.Text;
import haxepunk.ui.UIComponent;
import haxepunk.ui.skin.Skin;

/**
 * A basic label component
 */
@:access(com.haxepunk.graphics.Text)
class Label extends UIComponent
{
	public static function getTextFromLabelOptions(labelProperties:LabelOptions, text:String = "", ?width:Int, ?height:Int):Text
	{
		if (labelProperties == null) labelProperties = {};
		var labelWidth:Int = width == null ? 0 : width,
			labelAlign:TextFormatAlign = TextFormatAlign.CENTER,
			labelX:Float = 0,
			labelY:Float = 0;
		if (Reflect.hasField(labelProperties, "width")) labelWidth = Std.int(labelProperties.width);
		if (Reflect.hasField(labelProperties, "align")) labelAlign = labelProperties.align;
		if (Reflect.hasField(labelProperties, "x")) labelX = labelProperties.x;
		if (Reflect.hasField(labelProperties, "y")) labelY = labelProperties.y;

		var label = new Text(text, labelX, labelY, labelWidth, 0, labelProperties);
		if (height != null && !Reflect.hasField(labelProperties, "y"))
		{
			label.y = (height >> 1) - (label.textHeight >> 1);
		}

		return label;
	}

	public var text(get, set):String;
	public var font(get, set):String;
	public var size(get, set):Int;
	public var align(get, set):String;
	public var wordWrap(get, set):Bool;

	/**
	 * The label's text wrapped as an Image
	 */
	public var punkText:Text;

	/**
	 * The label's text
	 */
	var textString:String;

	/**
	 * Constructor
	 * @param	text the text to display
	 * @param	x X-Coordinate for the component
	 * @param	y Y-Coordinate for the component
	 * @param	width Width of the component
	 * @param	height Height of the component
	 * @param	skin Skin to use when rendering the component
	 */
	public function new(text:String = "", x:Float = 0, y:Float = 0, width:Int = 1, height:Int = 1, skin:Skin = null)
	{
		textString = text;

		super(x, y, width, height, skin);
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (skin.label == null) return;

		punkText = getTextFromLabelOptions(skin.label.labelProperties, textString);
		graphic = punkText;
	}

	/**
	 * Text string.
	 */
	function get_text():String return punkText.text;
	function set_text(value:String):String return punkText.text = value;

	/**
	 * Font family.
	 */
	function get_font():String return punkText.font;
	function set_font(value:String):String return punkText.font = value;

	/**
	 * Font size.
	 */
	function get_size():Int return punkText.size;
	function set_size(value:Int):Int return punkText.size = value;

	/**
	 * Alignment ("left", "center" or "right").
	 * Only relevant if text spans multiple lines.
	 */
	function get_align():String return punkText.align;
	function set_align(value:String):String return punkText.align = value;

	/**
	 * Automatic word wrapping.
	 */
	function get_wordWrap():Bool return punkText.wordWrap;
	function set_wordWrap(value:Bool):Bool return punkText.wordWrap = value;
}
