class_name HurtBox extends Area2D

@export var health_component: Health
		
func take_damage(amount: int) -> void:
	health_component.apply_damage(amount)
