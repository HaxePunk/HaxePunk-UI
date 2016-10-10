package haxepunk.ui;

import flash.display.BitmapData;
import flash.events.FocusEvent;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.text.TextFieldType;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import haxepunk.ui.skin.Skin;
import haxepunk.ui.skin.SkinImage;

/**
 * A generic editable text field.
 */
@:access(com.haxepunk.graphics.Text)
class TextArea extends Label
{
	/**
	 * Boolean; True if the component has been inititalized; Otherwise False.
	 */
	var initialized:Bool = false;

	var updateTextBuffer:Bool = false;

	/**
	 * Constructor
	 * @param	text text the String of text to display
	 * @param	x X-Coordinate of the component
	 * @param	y Y-Coordinate of the component
	 * @param	width Width of the component
	 * @param	height Height of the component
	 * @param	skin Skin to use when rendering the component
	 */
	public function new(text:String = "", x:Float = 0, y:Float = 0, width:Int = 0, height:Int = 0, skin:Skin = null)
	{
		super(text, x, y, width, height, skin);
		textControl._field.selectable = true;
		textControl._field.type = TextFieldType.INPUT;
		textControl._field.multiline = true;
		//textControl.width = (width != 0) ? width : 240;
		//textControl.height = (height != 0) ? height : 36;
		textControl._field.x = x;
		textControl._field.y = y;
		textControl.resizable = false;
		textControl.wordWrap = true;
		textControl._field.alpha = 0;
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (skin.textArea == null) return;

		textControl = Label.getTextFromLabelOptions(skin.textArea.labelProperties, textString);
		bg = getSkinImage(skin.textArea.background);
		addGraphic(bg);
		addGraphic(textControl);
	}

	override public function update():Void
	{
		super.update();

		if (!initialized)
		{
			HXP.stage.addChild(textControl._field);
			textControl._field.addEventListener(FocusEvent.FOCUS_IN, onFocusInText, false, 0, true);
			textControl._field.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutText, false, 0, true);
			initialized = true;
		}

		textControl._field.x = x - Std.int(HXP.camera.x);
		textControl._field.y = y - Std.int(HXP.camera.y);

		if (bg != null)
		{
			bg.width = width;
			bg.height = height;
		}
	}

	function onFocusInText(e:FocusEvent):Void
	{
		updateTextBuffer = true;
	}

	function onFocusOutText(e:FocusEvent):Void
	{
		updateTextBuffer = false;
		textControl.updateTextBuffer();
	}

	override public function added():Void
	{
		super.added();

		initialized = false;

		if (HXP.stage != null)
		{
			HXP.stage.addChild(textControl._field);
			textControl._field.addEventListener(FocusEvent.FOCUS_IN, onFocusInText, false, 0, true);
			textControl._field.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutText, false, 0, true);
			initialized = true;
		}
	}

	override public function removed():Void
	{
		super.removed();
		textControl._field.removeEventListener(FocusEvent.FOCUS_IN, onFocusInText);
		textControl._field.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOutText);
		HXP.stage.removeChild(textControl._field);
	}

	override function set_x(value:Float):Float
	{
		if (textControl != null) textControl._field.x = value * HXP.screen.fullScaleX;
		return super.set_x(value);
	}

	override function set_y(value:Float):Float
	{
		if (textControl != null) textControl._field.y = value * HXP.screen.fullScaleY;
		return super.set_y(value);
	}

	var bg:SkinImage;
}
