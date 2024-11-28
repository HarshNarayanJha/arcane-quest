class_name SwitchObject extends StaticBody2D

enum SWITCH_TYPE {
	ONETIME,
	TOGGLE
}

signal switch_toggle(state: bool)

@export_category("Switch")
@export var switch_type: SWITCH_TYPE
@export var state: bool = false
@export var disable_start: bool = false
@export var sprite: Sprite2D

@export var off_texture: Texture2D
@export var on_texture: Texture2D

@export_category("Events")
@export var interaction_area: InteractionArea

@export_subgroup("Emits")
@export var event_trigger: EventTrigger
@export var bool_event_trigger: BoolEventTrigger

func _ready() -> void:
	sprite.texture = off_texture
	interaction_area.interact.connect(toggle)
	bool_event_trigger.trigger.emit(state)
	switch_toggle.emit(state)
	if state:
		sprite.texture = on_texture
		event_trigger.trigger.emit()
		if switch_type == SWITCH_TYPE.ONETIME:
			interaction_area.disable()

	match switch_type:
		SWITCH_TYPE.ONETIME:
			interaction_area.action_name = "Press"
		SWITCH_TYPE.TOGGLE:
			interaction_area.action_name = "Toggle"

	if disable_start:
		disable()

func toggle() -> void:
	if (state and switch_type == SWITCH_TYPE.ONETIME):
		return

	state = !state
	if state:
		sprite.texture = on_texture
		event_trigger.trigger.emit()
		if switch_type == SWITCH_TYPE.ONETIME:
			interaction_area.disable()
	else:
		sprite.texture = off_texture

	switch_toggle.emit(state)
	bool_event_trigger.trigger.emit(state)


func _exit_tree() -> void:
	interaction_area.interact.disconnect(toggle)

func disable() -> void:
	hide()
	interaction_area.disable()
	set_process_mode(ProcessMode.PROCESS_MODE_DISABLED)

func enable() -> void:
	set_process_mode(ProcessMode.PROCESS_MODE_INHERIT)
	interaction_area.enable()
	show()
