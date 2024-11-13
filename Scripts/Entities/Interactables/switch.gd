class_name SwitchObject extends StaticBody2D

enum SWITCH_TYPE {
	ONETIME,
	TOGGLE
}

signal switch_toggle(state: bool)

@export_category("Switch")
@export var switch_type: SWITCH_TYPE
@export var state: bool = false
@export var sprite: Sprite2D

@export var off_texture: Texture2D
@export var on_texture: Texture2D

@export_category("Events")
@export var interaction_area: InteractionArea
@export var event_trigger: EventTrigger
@export var bool_event_trigger: BoolEventTrigger

func _ready() -> void:
	sprite.texture = off_texture
	interaction_area.interact.connect(toggle)
	
func toggle() -> void:
	if (state and switch_type == SWITCH_TYPE.ONETIME):
		return
		
	state = !state
	if state:
		sprite.texture = on_texture
		event_trigger.trigger.emit()
	else:
		sprite.texture = off_texture
		
	switch_toggle.emit(state)
	bool_event_trigger.trigger.emit(state)
	

func _exit_tree() -> void:
	interaction_area.interact.disconnect(toggle)
