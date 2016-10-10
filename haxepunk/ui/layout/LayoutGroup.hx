package haxepunk.ui.layout;

import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.EntityList;
import haxepunk.ui.layout.Layout;

@:enum
abstract LayoutType(Int)
{
	var Stack = 0;
	var Horizontal = 1;
	var Vertical = 2;
	var Grid = 3;
}

/**
 * An EntityList which can reposition its entities on resize.
 */
class LayoutGroup extends EntityList<Entity>
	implements ILayout
{
	public var layoutData:Layout;

	public var childLayoutType:LayoutType = LayoutType.Stack;
	public var paddingX:Float = 0;
	public var paddingY:Float = 0;

	/* Amount of spacing between children. Used for Horizontal/Vertical/Grid. */
	public var spacing:Float = 0;

	public var percentWidth:Float = 1;
	public var percentHeight:Float = 1;
	public var widthBounds:Bounds = new Bounds();
	public var heightBounds:Bounds = new Bounds();

	public var wraps:Null<Entity>;
	public var fillParent:Bool = false;
	public var stretchContents:Bool = false;

	/**
	 * @param	wraps			If provided, this LayoutGroup wraps this Entity
	 * @param	percentWidth	Percent of available width to fill. If this
	 * 							LayoutGroup has no parent, percent of screen width.
	 * @param	percentHeight	Percent of available height to fill. If this
	 * 							LayoutGroup has no parent, percent of screen height.
	 * @param	childLayoutType	How child entities should be arranged.
	 */
	public function new(?wraps:Entity, ?percentWidth:Float=1, ?percentHeight:Float=1, ?childLayoutType:LayoutType=LayoutType.Stack)
	{
		super();

		this.wraps = wraps;
		if (wraps == null)
		{
			fillParent = true;
		}
		this.percentWidth = percentWidth;
		this.percentHeight = percentHeight;
		this.childLayoutType = childLayoutType;

		layoutData = new Layout();

		if (wraps != null) super.add(wraps);
	}

	/**
	 * Add an Entity. If the Entity isn't a LayoutGroup, it will be wrapped
	 * in one, so the return value will always have a `layoutData` field.
	 */
	override public function add(object:Entity):LayoutGroup
	{
		if (Std.is(object, ILayout))
		{
			var layout = cast object;
			layout.layoutData.parent = this;
		}
		else
		{
			//object.cameras = this.cameras;
			var wrapper:LayoutGroup = new LayoutGroup(object);
			wrapper.layoutData.parent = this;
			object = wrapper;
		}
		//object.cameras = this.cameras;

		return cast super.add(object);
	}

	/**
	 * Position all children. If any children are LayoutGroups, their children
	 * will also be positioned.
	 */
	public function layoutChildren(?x:Float, ?y:Float, ?parentWidth:Float, ?parentHeight:Float):Void
	{
		if (x == null)
		{
			var totalScaleX = HXP.screen.fullScaleX,
				totalScaleY = HXP.screen.fullScaleY;

			// topmost LayoutGroup should fill the screen
			x = -Math.min(0, HXP.screen.x) / totalScaleX;
			y = -Math.min(0, HXP.screen.y) / totalScaleY;
			parentWidth = HXP.screen.width / totalScaleX;
			parentHeight = HXP.screen.height / totalScaleY;
		}

		if (fillParent)
		{
			width = widthBounds.iclamp(parentWidth * percentWidth);
			height = heightBounds.iclamp(parentHeight * percentHeight);
		}
		else if (wraps != null)
		{
			width = widthBounds.iclamp(wraps.width);
			height = heightBounds.iclamp(wraps.height);
		}
		if (wraps != null && stretchContents)
		{
			wraps.width = width;
			wraps.height = height;
		}

		x += layoutData.getXOffset(width, parentWidth);
		y += layoutData.getYOffset(height, parentHeight);
		this.x = x;
		this.y = y;

		var childrenWidth:Float = 0;
		var childrenHeight:Float = 0;
		var maxRowHeight:Float = 0;

		for (member in entities)
		{
			member.x = x;
			member.y = y;

			if (Std.is(member, ILayout))
			{
				var layout:ILayout = cast member;
				layout.layoutChildren(
					x + paddingX,
					y + paddingY,
					width - paddingX * 2,
					height - paddingY * 2
				);
			}
			else
			{
				member.x += paddingX;
				member.y += paddingY;
			}

			switch (childLayoutType)
			{
				case Horizontal:
					member.x += childrenWidth;
					childrenWidth += spacing + member.width;

				case Vertical:
					member.y += childrenHeight;
					childrenHeight += spacing + member.height;

				case Grid:
					if (childrenWidth + member.width > width - paddingX*2)
					{
						// move to the next row
						childrenWidth = 0;
						childrenHeight += spacing + maxRowHeight;
						maxRowHeight = 0;
					}
					member.x += childrenWidth;
					member.y += childrenHeight;
					childrenWidth += spacing + member.width;
					maxRowHeight = Math.max(maxRowHeight, member.height);

				default: {}
			}
		}
	}

	override function get_width() return this.width;
	override function set_width(value:Int) return this.width = value;
	override function get_height() return this.height;
	override function set_height(value:Int) return this.height = value;
}
