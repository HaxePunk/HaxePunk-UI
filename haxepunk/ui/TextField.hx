package haxepunk.ui;

import com.haxepunk.graphics.Text;
import haxepunk.ui.skin.Skin;

/**
 * A single line TextArea.
 */
@:access(com.haxepunk.graphics.Text)
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
		punkText._field.multiline = false;
		punkText._field.wordWrap = false;
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (skin.punkTextField == null) return;

		punkText = Label.getTextFromLabelOptions(skin.punkLabel.labelProperties, textString);
		bg = getSkinImage(skin.punkTextField.background);

		addGraphic(bg);
		addGraphic(punkText);
	}
}
