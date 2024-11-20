class_name Bomb extends StaticBody2D

@export var hitbox: HitBox
@export var hitbox_collision: CollisionShape2D
@export var time_to_detonate: float
@export var impact_radius: float
@export var impact_time: float

func _ready() -> void:
	(hitbox_collision.shape as CircleShape2D).set_radius(0)
	
	print("Bomb Instantiated!")
	get_tree().create_timer(time_to_detonate).timeout.connect(detonate)
	
func detonate():
	print("!!!BLAST!!!")
	var tween := get_tree().create_tween()
	tween.tween_property(hitbox_collision.shape as CircleShape2D, "radius", impact_radius, impact_time)
	tween.tween_callback(queue_free)
