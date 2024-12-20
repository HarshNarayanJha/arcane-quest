class_name Bomb extends StaticBody2D

@export var hitbox: HitBox
@export var hitbox_collision: CollisionShape2D
@export var time_to_detonate: float
@export var impact_radius: float
@export var impact_time: float
@export var sfx: AudioStream

func _ready() -> void:
	hitbox.disable()
	(hitbox_collision.shape as CircleShape2D).set_radius(0)
	get_tree().create_timer(time_to_detonate).timeout.connect(detonate)

func detonate():
	hitbox.enable()
	MusicPlayer.play_sfx(sfx, global_position)
	var tween := get_tree().create_tween()
	tween.tween_property(hitbox_collision.shape as CircleShape2D, "radius", impact_radius, impact_time)
	tween.tween_callback(queue_free)

	var shake = procam.get_addons()[1]
	shake.shake()
	await get_tree().create_timer(0.2).timeout
	shake.stop()
