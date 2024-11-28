class_name MeleeWeapon extends StaticBody2D

@export var weapon_data: WeaponData
@export var sprite: Sprite2D
@export var hitbox: HitBox

var attack_speed: float
var damage: float
var knockback: float

func _ready() -> void:
	assert(weapon_data != null, "Weapon Data is null for %s" % name)
	attack_speed = weapon_data.attack_speed
	damage = weapon_data.damage
	knockback = weapon_data.knockback
	hitbox.disable()

	hitbox.damage_amount = damage
	hitbox.knockback_amount = knockback
	print(hitbox.knockback_amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
