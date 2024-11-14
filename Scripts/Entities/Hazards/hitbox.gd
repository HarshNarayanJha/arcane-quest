class_name HitBox extends Area2D

@export var damage_amount: int

func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		var hurtbox := area as HurtBox
		hurtbox.take_damage(damage_amount)
