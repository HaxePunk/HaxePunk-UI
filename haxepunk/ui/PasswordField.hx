package haxepunk.ui;

import com.haxepunk.graphics.Text;
import haxepunk.ui.TextField;

import haxepunk.ui.skin.Skin;

/**
 * A password field TextField.
 */
@:access(com.haxepunk.graphics.Text)
class PasswordField extends TextField
{
	/**
	 * @param	x		X-Coordinate for the component
	 * @param	y		Y-Coordinate for the component
	 * @param	width	Width of the component
	 * @param	height	Height of the component
	 * @param	skin	Skin to use when rendering the component
	 */
	public function new(x:Float = 0, y:Float = 0, width:Int = 0, text:String = "", skin:Skin = null)
	{
		super(text, x, y, width, skin);

		textControl._field.displayAsPassword = true;
	}

	/**
	 * Additional setup steps for this component
	 * @param	skin	Skin to use when rendering the component
	 */
	override function setupSkin(skin:Skin):Void
	{
		if (skin.passwordField == null) return;

		textControl = Label.getTextFromLabelOptions(skin.label.labelProperties, textString);
		bg = getSkinImage(skin.passwordField.background);

		addGraphic(bg);
		addGraphic(textControl);
	}
}
