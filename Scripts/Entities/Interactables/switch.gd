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
@export var event_trigger: EventTrigger

func _ready() -> void:
	sprite.texture = off_texture
	
func _physics_process(delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		toggle()
	
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
