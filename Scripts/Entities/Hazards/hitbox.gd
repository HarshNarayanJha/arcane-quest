class_name HitBox extends Area2D

@export var damage_amount: int
@export var knockback_amount: float

func disable() -> void:
	self.monitoring = false

func enable() -> void:
	self.monitoring = true

func _on_area_entered(area: Area2D) -> void:
	if area is HurtBox:
		# don't damage self
		if area.get_parent() == get_parent():
			return
		var hurtbox := area as HurtBox
		hurtbox.take_damage(damage_amount, global_position, knockback_amount)
