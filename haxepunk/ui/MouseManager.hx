package haxepunk.ui;

import flash.errors.Error;
import flash.geom.Point;
import haxepunk.HXP;
import haxepunk.Entity;
import haxepunk.input.Input;
import haxepunk.ui.UIComponent;

/**
 * Allow Entities to register callbacks on mouse interaction. Based on
 * FlxMouseEventManager by TiagoLr.
 *
 * To use a MouseManager, add it to the scene, then call the `add` method to add
 * Entities with mouse event callbacks. Multiple MouseManagers can be added to
 * the same scene. All entities within one MouseManager must be the same
 * collision type.
 */
class MouseManager extends Entity
{
	var _registeredObjects:Map<Entity, MouseData> = new Map();
	var _collisions:Array<Entity> = new Array();
	var _lastCollisions:Array<Entity> = new Array();

	public function new()
	{
		super();
		width = height = 0;
		collidable = false;
		visible = false;
	}

	/**
	 * Adds an object to the MouseManager registry.
	 *
	 * @param	entity
	 * @param	onPress			Callback when mouse is pressed down over this object.
	 * @param	onRelease		Callback when mouse is released over this object.
	 * @param	onEnter			Callback when mouse is this object.
	 * @param	onExit			Callback when mouse moves out of this object.
	 * @param	fallThrough		If true, other objects overlaped by this will still receive mouse events.
	 * @param	PixelPerfect	If true, the collision check will be pixel-perfect. Only works for FlxSprites.
	 * @param	MouseButtons	The mouse buttons that can trigger callbacks. Left only by default.
	 */
	public function add(
		entity:Entity,
		?onPress:Void -> Void,
		?onRelease:Void -> Void,
		?onEnter:Void -> Void,
		?onExit:Void -> Void,
		fallThrough = false):Entity
	{
		if (this.type == "")
		{
			this.type = entity.type;
		}
		else if (this.type != entity.type)
		{
			throw "Entities added to a MouseManager must all be the same type.";
		}

		var data:MouseData = new MouseData(entity, onPress, onRelease, onEnter, onExit, fallThrough);
		_registeredObjects[entity] = data;
		return entity;
	}

	/**
	 * Removes a registered object from the registry.
	 */
	public function remove(entity:Entity):Entity
	{
		if (_registeredObjects.exists(entity))
		{
			_registeredObjects.remove(entity);
		}
		return entity;
	}

	/**
	 * Removes all registered objects from the registry.
	 */
	public function clear():Void
	{
		for (key in _registeredObjects.keys())
		{
			_registeredObjects.remove(key);
		}
		while (_lastCollisions.length > 0)
		{
			_lastCollisions.pop();
		}
	}

	public function getData(entity:Entity):Null<MouseData>
	{
		return _registeredObjects.exists(entity) ? _registeredObjects[entity] : null;
	}

	override public function update():Void
	{
		super.update();

		var collisions:Array<Entity> = _collisions;
		// make sure the mouse is onscreen before checking for collisions
		if (HXP.stage.mouseX >= HXP.screen.x &&
			HXP.stage.mouseY >= HXP.screen.y &&
			HXP.stage.mouseX <= HXP.screen.x + HXP.screen.width &&
			HXP.stage.mouseY <= HXP.screen.y + HXP.screen.height)
		{
			scene.collidePointInto(type, scene.mouseX, scene.mouseY, collisions);
		}

		for (i in 0 ... collisions.length - 1)
		{
			var current = getData(collisions[i]);
			if (current != null && !current.fallThrough)
			{
				collisions.splice(i + 1, collisions.length - (i + 1));
				break;
			}
		}

		// onEnter
		for (entity in collisions)
		{
			var current = getData(entity);
			if (current == null) continue;
			if (current.onEnter != null)
			{
				if (_lastCollisions.indexOf(entity) == -1)
				{
					current.onEnter();
				}
			}
		}

		// onPress
		for (entity in collisions)
		{
			var current = getData(entity);
			if (current == null) continue;
			if (current.onPress != null)
			{
				if (Input.mousePressed)
				{
					current.onPress();
				}
			}
		}

		// onRelease
		for (entity in collisions)
		{
			var current = getData(entity);
			if (current == null) continue;
			if (current.onRelease != null)
			{
				if (Input.mouseReleased)
				{
					current.onRelease();
				}
			}
		}

		// onExit
		for (entity in _lastCollisions)
		{
			var current = getData(entity);
			if (current == null) continue;
			if (current.onExit != null)
			{
				if (collisions.indexOf(entity) == -1)
				{
					current.onExit();
				}
			}
		}

		_collisions = _lastCollisions;
		if (_collisions.length > 0) _collisions.splice(0, _collisions.length);
		_lastCollisions = collisions;
	}
}

class MouseData
{
	public var entity:Entity;
	public var onPress:Void -> Void;
	public var onRelease:Void -> Void;
	public var onEnter:Void -> Void;
	public var onExit:Void -> Void;
	public var fallThrough:Bool;

	public function new(
		entity:Entity,
		onPress:Void -> Void,
		onRelease:Void -> Void,
		onEnter:Void -> Void,
		onExit:Void -> Void,
		fallThrough:Bool)
	{
		this.entity = entity;
		this.onPress = onPress;
		this.onRelease = onRelease;
		this.onEnter = onEnter;
		this.onExit = onExit;
		this.fallThrough = fallThrough;
	}
}
