package haxepunk.ui;

import haxepunk.graphics.Text;
import haxepunk.ui.skin.Skin;

/**
 * A single line TextArea.
 */
@:access(haxepunk.graphics.Text)
class TextField extends TextArea
{
	/**
	 * Constructor
	 * @param	text the String of text to display
	 * @param	x X-Coordinate of the component
	 * @param	y Y-Coordinate of the component
	 * @param	width Width of the component
	 * @param	skin Skin to use when rendering the component
	 */
	public function new(text:String = "", x:Float = 0, y:Float = 0, width:Int = 0, skin:Skin = null)
	{
		super(text, x, y, (width != 0) ? width:240, 20, skin);
		textControl._field.multiline = false;
		textControl._field.wordWrap = false;
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (skin.textField == null) return;

		textControl = Label.getTextFromLabelOptions(skin.label.labelProperties, textString);
		bg = getSkinImage(skin.textField.background);

		addGraphic(bg);
		addGraphic(textControl);
	}
}
