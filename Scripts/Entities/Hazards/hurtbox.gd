class_name HurtBox extends Area2D

@export var health_component: Health
@export var invincible: bool
@export var invincibility_time: float = 5

var invincibility_timer: SceneTreeTimer

signal took_damage(amount: int, knockback: float)
# TODO: Add signals for invincibility

"""
Makes this hurtbox invincible, return false if already invincible, otherwise true
"""
func make_invincible(duration: float = invincibility_time) -> bool:
	if invincible: return false
	
	invincible = true
	invincibility_timer = get_tree().create_timer(duration, false)
	invincibility_timer.timeout.connect(revoke_invincible)
	
	return true
	
func revoke_invincible() -> void:
	invincible = false

func take_damage(amount: int, hitbox_position: Vector2, knockback: float = 0) -> void:
	health_component.apply_damage(amount)
	took_damage.emit(amount, hitbox_position, knockback)
