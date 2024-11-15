class_name Arrow extends RigidBody2D

@export var hitbox: HitBox
@export var fire_speed: float

func fire(direction: Vector2, speed: float = fire_speed) -> void:
	set_linear_velocity(direction * speed)

func _ready() -> void:
	get_tree().create_timer(20).timeout.connect(queue_free)

func _process(delta: float) -> void:
	pass

func _on_object_detector_area_entered(area: Area2D) -> void:
	if not linear_velocity.is_equal_approx(Vector2.ZERO):
		queue_free()

func _on_object_detector_body_entered(body: Node2D) -> void:
	if not linear_velocity.is_equal_approx(Vector2.ZERO):
		queue_free()
