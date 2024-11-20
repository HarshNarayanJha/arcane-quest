class_name Crate extends RigidBody2D

@export var push_speed := 30.0

var push_direction := Vector2.ZERO : set = _set_push


func _physics_process(delta: float) -> void:
	if push_direction:
		linear_velocity = linear_velocity.move_toward(push_direction * push_speed, 100 * delta)
	else:
		linear_velocity = linear_velocity.move_toward(Vector2.ZERO, 1000 * delta)

func _set_push(val: Vector2) -> void:
	push_direction = val
