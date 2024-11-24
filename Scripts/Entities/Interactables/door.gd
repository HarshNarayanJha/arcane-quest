extends StaticBody2D

enum DOOR_TYPE {
	SELF,
	TRIGGERED,
	KEY
}

@export_category("Door")
@export var door_type: DOOR_TYPE
@export var is_open: bool = false
@export var sprite: Sprite2D
@export var collision: CollisionShape2D

@export var closed_texture: Texture2D
@export var open_texture: Texture2D


@export_category("Events")
@export var interaction_area: InteractionArea

@export_subgroup("Connects")
@export var trigger: BoolEventTrigger

func _ready() -> void:
	if (door_type == DOOR_TYPE.SELF):
		set_door(true)
		interaction_area.interact.connect(toggle_door)
		return
		
	if (door_type == DOOR_TYPE.TRIGGERED):
		set_door(true)
		trigger.trigger.connect(set_door_trigger)
		return
		
	if (door_type == DOOR_TYPE.KEY):
		set_door(true)
		interaction_area.interact.connect(check_key)
	
func _exit_tree() -> void:
	if (door_type == DOOR_TYPE.SELF):
		interaction_area.interact.disconnect(toggle_door)
		
	if (door_type == DOOR_TYPE.TRIGGERED):
		trigger.trigger.disconnect(set_door_trigger)
		
	if (door_type == DOOR_TYPE.KEY):
		interaction_area.interact.disconnect(check_key)
		

func check_key() -> void:
	if Globals.inventory_has_key():
		Globals.inventory_use_key()
		open()
		
	
func toggle_door() -> void:
	set_door(is_open)
		
func set_door_trigger(trigger_state: bool) -> void:
#	# Need to invert the logic here, since switch open needs to open the door, hence set_door(false)
	set_door(not trigger_state)
	
func set_door(state: bool) -> void:
	if state:
		close()
	else:
		open()

func open() -> void:
	is_open = true
	collision.set_deferred("disabled", true)
	if open_texture:
		sprite.set_texture(open_texture)
	else:
		sprite.hide()
		
func close() -> void:
	is_open = false
	collision.set_deferred("disabled", false)
	sprite.show()
	sprite.set_texture(closed_texture)
