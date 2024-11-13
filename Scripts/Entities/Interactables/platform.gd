extends AnimatableBody2D

enum PLATFORM_TYPE {
	STATIC,
	TRIGGERED
}

@export_category("Platform")
@export var platform_type: PLATFORM_TYPE
@export var sprite: Sprite2D
@export var collision: CollisionShape2D

@export_category("Events")
@export_subgroup("Connects")
@export var trigger: BoolEventTrigger


func _ready() -> void:
	if (platform_type == PLATFORM_TYPE.STATIC):
		set_platform(true)
		return
		
	if (platform_type == PLATFORM_TYPE.TRIGGERED):
		set_platform(false)
		trigger.trigger.connect(set_platform)
		return
		
func _exit_tree() -> void:
	if (platform_type == PLATFORM_TYPE.TRIGGERED):
		trigger.trigger.disconnect(set_platform)

func _process(delta: float) -> void:
	pass
	
func set_platform(state: bool) -> void:
	if state:
		show_platform()
	else:
		hide_platform()
		
func show_platform() -> void:
	sprite.show()
	collision.set_deferred("disabled", false)

func hide_platform() -> void:
	sprite.hide()
	collision.set_deferred("disabled", true)
