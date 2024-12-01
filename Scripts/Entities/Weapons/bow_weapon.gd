class_name BowWeapon extends StaticBody2D

@export var arrow_scene: PackedScene
@export var weapon_data: WeaponData
@export var sprite: Sprite2D
@export var fire_point: Marker2D
@export var fire_speed: float

var fire_timer: SceneTreeTimer
var arrow: Arrow = null

var attack_speed: float
var damage: float
var knockback: float

var _active: bool = false

var can_shoot: bool = false

func _ready() -> void:
	assert(weapon_data != null, "Weapon Data is null for %s" % name)
	attack_speed = weapon_data.attack_speed
	damage = weapon_data.damage
	knockback = weapon_data.knockback

## Prepares an arrow by creating it, and setting up can_shoot timer
func _prepare_arrow() -> void:
	can_shoot = false

	arrow = _create_arrow()
	#prints("Preparing arrow to fire in", 100 / attack_speed)

	if fire_timer:
		fire_timer.timeout.disconnect(_ready_to_fire)
	fire_timer = get_tree().create_timer(100 / attack_speed)

	fire_timer.timeout.connect(_ready_to_fire)

## Just set's can shoot to true
## TODO: Add SFX and FX
func _ready_to_fire() -> void:
	can_shoot = true
	arrow.translate(Vector2.UP * 10)

## Called by the Bow State on Player to shoot_arrow when key is released
func shoot_arrow() -> void:
	if not _active:
		if arrow:
			arrow.queue_free()
		return

	if not can_shoot:
		if arrow:
			arrow.queue_free()
		return

	can_shoot = false
	var pos := arrow.global_transform
	arrow.get_parent().remove_child(arrow)

	get_tree().root.add_child(arrow)
	arrow.z_index = 2
	arrow.global_transform = pos

	#prints("Arrow Fired")
	arrow.fire(global_transform.basis_xform(Vector2.UP), fire_speed, damage, knockback)

func cancel_arrow() -> void:
	if arrow:
		arrow.queue_free()

## Instantiates an arrow
func _create_arrow() -> Arrow:
	var arrow: Arrow = arrow_scene.instantiate()
	fire_point.add_child(arrow)

	arrow.z_index = -1
	arrow.position = Vector2.ZERO

	return arrow

## Enable the bow
func enable() -> void:
	_active = true
	sprite.show()

	_prepare_arrow()

## Disable the bow
func disable() -> void:
	_active = false
	sprite.hide()

	can_shoot = false

	if fire_timer:
		fire_timer.timeout.disconnect(_ready_to_fire)

	arrow = null
