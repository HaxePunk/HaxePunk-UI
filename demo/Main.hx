import haxepunk.Engine;
import haxepunk.HXP;
import haxepunk.screen.UniformScaleMode;
import haxepunk.ui.UI;


class Main extends Engine
{
	override public function init()
	{
		HXP.console.enable();
		HXP.scene = new MainScene();
		UI.skin = new haxepunk.ui.skins.NESSkin();

		HXP.screen.scaleMode = new UniformScaleMode(UniformScaleType.Expand);
		HXP.screen.color = 0x8080c0;
	}

	public static function main() new Main();
}
