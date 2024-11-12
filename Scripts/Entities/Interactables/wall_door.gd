class_name WallDoorObject extends StaticBody2D

@export var sprite: Sprite2D
@export var collision: CollisionShape2D

@export var trigger: EventTrigger

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trigger.trigger.connect(open)
	
func _exit_tree() -> void:
	trigger.trigger.disconnect(open)

func open() -> void:
	print("Door Open")
	set_process(false)
	collision.set_deferred("disabled", true)
	sprite.set_visible(false)
