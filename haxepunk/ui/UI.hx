package haxepunk.ui;

import haxepunk.ui.UIComponent;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.utils.Input;

import haxepunk.ui.skin.Skin;

@:final class UI
{
	/**
	 * The current version of Punk.UI
	 */
	public static inline var VERSION:String = "1.0";

	/**
	 * The current skin being used by Punk.UI
	 */
	public static var skin(get, set):Skin;
	static inline function get_skin():Skin
	{
		if (_skin == null)
		{
			_skin = new haxepunk.ui.skins.Default();
		}
		return _skin;
	}
	static inline function set_skin(skin:Skin):Skin return _skin = skin;
	static var _skin:Skin;

	/**
	 * Determines if the mouse cursor is hovering over a UIComponent
	 * @param	component the component to test
	 * @param	onlyOnTop only return true if the component being tested is the top most element
	 * @param	screenMouse If the mouse coordinates system should be relative to the screen
	 * @return Boolean value indicating if the supplied component has the mouse hovering over it
	 */
	public static function mouseIsOver(component:UIComponent, onlyOnTop:Bool = true, screenMouse:Bool = false):Bool
	{
		var w:Scene = component.scene;
		var mx:Float = w.mouseX;
		var my:Float = w.mouseY;
		if (screenMouse)
		{
			mx = Input.mouseX;
			my = Input.mouseY;
		}
		var x:Float = component.x;
		var y:Float = component.y;

		var collide:Bool = false;

		if (!onlyOnTop) collide = component.collidePoint(x, y, mx, my)
		else collide = w.collidePoint(component.type, mx, my) == component;

		if (component._panel != null) collide = collide && component._panel.collidePoint(component._panel.x, component._panel.y, mx, my);

		return collide;
	}

	public function new() {}
}
