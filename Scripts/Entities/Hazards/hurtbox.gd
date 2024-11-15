class_name HurtBox extends Area2D

@export var health_component: Health

signal took_damage(amount: int, knockback: float)
		
func take_damage(amount: int, hitbox_position: Vector2, knockback: float = 0) -> void:
	health_component.apply_damage(amount)
	took_damage.emit(amount, hitbox_position, knockback)
