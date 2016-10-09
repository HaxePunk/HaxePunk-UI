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
    public var punkButton:SkinButtonElement;
    /**
     * Reference to the Toggle Button skin
     */
    public var punkToggleButton:SkinToggleButtonElement;
    /**
     * Reference to the Radio Button skin
     */
    public var punkRadioButton:SkinToggleButtonElement;
    
    /**
     * Reference to the Label skin
     */
    public var punkLabel:SkinHasLabelElement;
    /**
     * Reference to the PunkTextArea skin
     */
    public var punkTextArea:SkinLabelElement;
    /**
     * Reference to the TextField skin
     */
    public var punkTextField:SkinLabelElement;
    /**
     * Reference to the PasswordField skin
     */
    public var punkPasswordField:SkinLabelElement;
    
    /**
     * Reference to the Window skin
     */
    public var punkWindow:SkinWindowElement;
    
    /**
     * Constructor. This class should be extended in order to create a custom skin.
     */
    public function new() {}
}
