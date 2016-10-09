package haxepunk.ui;


/**
 * Contains and controls a collection of grouped radio buttons.
 */
class RadioButtonGroup
{
	/**
	 * Function to call when the components state changes
	 */
	public var onChange:Function = null;
	/**
	 * Vector containing the grouped PunkRadioButtons
	 */
	var radioButtons:Array<PunkRadioButton> = new Array<PunkRadioButton>();

	/**
	 * Constructor
	 * @param	onChange Function to call when the group's state changes
	 */
	public function new(onChange:Function = null)
	{
		this.onChange = onChange;
	}

	/**
	 * Add a PunkRadioButton to the collection
	 * @param	radioButton PunkRadioButton to add
	 */
	function add(radioButton:RadioButton):Void
	{
		if (Lambda.indexOf(radioButtons, radioButton) < 0) radioButtons.push(radioButton);
	}

	/**
	 * Remove a PunkRadioButton from the collection
	 * @param	radioButton PunkRadioButton to remove
	 */
	function remove(radioButton:RadioButton):Void
	{
		var index:Int = Lambda.indexOf(radioButtons, radioButton);
		if (index > -1) radioButtons.splice(index, 1);
	}

	/**
	 * Set a the target radio button to the on state; all others to the off state.
	 * @param	radioButton PunkRadioButton to turn on
	 */
	function toggleOn(radioButton:RadioButton):Void
	{
		if (radioButton.on) return;

		for (b in radioButtons)
		{
			if (b == radioButton)
			{
				b.toggle(true);
			}
			else
			{
				if (b.on) b.toggle(false);
			}
		}

		if (onChange != null) onChange(radioButton.id);
	}
}
