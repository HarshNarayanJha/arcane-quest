class_name Arrow extends RigidBody2D

@export var shoot_sfx: AudioStream
@export var hit_sfx: AudioStream
@export var hitbox: HitBox
@export var fire_speed: float

var play_sounds := true

func fire(
	direction: Vector2,
	speed: float = fire_speed,
	damage_amount: int = -1,
	knockback: float = -1
) -> void:
	set_linear_velocity(direction * speed)
	if damage_amount != -1:
		hitbox.damage_amount = damage_amount
	if knockback != -1:
		hitbox.knockback_amount = knockback

	if play_sounds:
		MusicPlayer.play_sfx(shoot_sfx, global_position)

func _ready() -> void:
	get_tree().create_timer(20).timeout.connect(queue_free)

func _on_object_detector_area_entered(area: Area2D) -> void:
	if not linear_velocity.is_equal_approx(Vector2.ZERO):
		if play_sounds:
			MusicPlayer.play_sfx(hit_sfx, global_position)
		queue_free()

func _on_object_detector_body_entered(body: Node2D) -> void:
	if not linear_velocity.is_equal_approx(Vector2.ZERO):
		if play_sounds:
			MusicPlayer.play_sfx(hit_sfx, global_position)
		queue_free()
