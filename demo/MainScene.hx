import com.haxepunk.Scene;

import com.haxepunk.HXP;
import haxepunk.ui.Button;
import haxepunk.ui.Label;
import haxepunk.ui.PasswordField;
import haxepunk.ui.TextArea;
import haxepunk.ui.TextField;
import haxepunk.ui.ToggleButton;
import haxepunk.ui.layout.LayoutGroup;
import haxepunk.ui.MouseManager;
import haxepunk.ui.RadioButton;
import haxepunk.ui.RadioButtonGroup;

class MainScene extends Scene
{
	public function new()
	{
		super();

		var mouseManager = new MouseManager();
		add(mouseManager);

		var btn = new Button(0, 0, 256, 256, "BIG BUTTON", function() HXP.engine.pushScene(new PopupScene()), mouseManager);
		add(btn);

		var parentLayout = new LayoutGroup(LayoutType.Horizontal);
		parentLayout.paddingX = parentLayout.paddingY = 16;

		var layout = new LayoutGroup(0.5, LayoutType.Vertical);
		layout.spacing = 32;
		var btn = new Button(0, 0, 128, 32, "Press me", mouseManager);
		layout.add(btn);
		var btn = new Button(0, 0, 128, 32, "Or me", mouseManager);
		layout.add(btn);
		var btn = new Button(0, 0, 128, 32, "But not me", mouseManager);
		btn.enabled = false;
		layout.add(btn);
		var grp = new RadioButtonGroup(function() trace("CHANGED"));
		var btn = new RadioButton(grp, "id1", 0, 0, 24, 24, "Option 1", mouseManager);
		layout.add(btn);
		var btn = new RadioButton(grp, "id2", 0, 0, 24, 24, "Option 2", mouseManager);
		layout.add(btn);
		var btn = new RadioButton(grp, "id3", 0, 0, 24, 24, "Option 3", mouseManager);
		layout.add(btn);
		parentLayout.add(layout);

		var layout = new LayoutGroup(0.5, LayoutType.Vertical);
		layout.spacing = 8;
		layout.add(new ToggleButton(10, 40, 100, 25, false, "Toggle me", mouseManager));
		layout.add(new Label("Read me", 125, 10, 128, 32));
		layout.add(new TextField("Write something", 125, 40, 200));
		layout.add(new PasswordField(125, 70, 200));
		layout.add(new TextArea("You could write a book here!", 330, 10, 300, 228));
		parentLayout.add(layout);

		add(parentLayout);
		parentLayout.layoutChildren();
	}
}
