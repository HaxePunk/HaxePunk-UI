package haxepunk.ui.skin;

import haxepunk.ui.skin.SkinButtonElement;
import haxepunk.ui.skin.SkinHasLabelElement;
import haxepunk.ui.skin.SkinLabelElement;
import haxepunk.ui.skin.SkinToggleButtonElement;
import haxepunk.ui.skin.SkinWindowElement;

/**
 * Base class that is extended when creating a new skin for Punk.UI
 */
class Skin
{
	/**
	 * Reference to the Button skin
	 */
	public var button:SkinButtonElement;
	/**
	 * Reference to the Toggle Button skin
	 */
	public var toggleButton:SkinToggleButtonElement;
	/**
	 * Reference to the Radio Button skin
	 */
	public var radioButton:SkinToggleButtonElement;

	/**
	 * Reference to the Label skin
	 */
	public var label:SkinHasLabelElement;
	/**
	 * Reference to the PunkTextArea skin
	 */
	public var textArea:SkinLabelElement;
	/**
	 * Reference to the TextField skin
	 */
	public var textField:SkinLabelElement;
	/**
	 * Reference to the PasswordField skin
	 */
	public var passwordField:SkinLabelElement;

	/**
	 * Reference to the Window skin
	 */
	public var window:SkinWindowElement;

	/**
	 * Constructor. This class should be extended in order to create a custom skin.
	 */
	public function new() {}
}
