class_name Enemy extends CharacterBody2D

@export var enemy_data: EnemyData
@export var state_machine: EnemyStateMachine
@export var sprite: Sprite2D
@export var animation: AnimationPlayer
@export var hurtbox: HurtBox
@export var health: Health

var player: Player
var speed: float
var acceleration: float
var deceleration: float

var direction := Vector2.ZERO
var knockback_velocity := Vector2.ZERO

func _ready() -> void:
	assert(enemy_data != null, "Enemy Data Not Set!")
	load_data()
	state_machine.init(self)

	hurtbox.took_damage.connect(_took_damage)
	health.died.connect(queue_free)

	Globals.player_changed.connect(set_player)
	if Globals.player:
		set_player(Globals.player)

func set_player(pl: Player) -> void:
	player = pl

func load_data() -> void:
	speed = enemy_data.speed
	acceleration = enemy_data.acceleration
	deceleration = enemy_data.deceleration
	#sprite.texture = enemy_data.player_sprite

func _physics_process(delta: float) -> void:

	# overwrite velocity with knockback, if any
	if knockback_velocity.length() > 0:
		velocity = knockback_velocity * speed * delta
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, deceleration * delta)

	move_and_slide()

func _took_damage(amount: int, hitbox_position: Vector2, knockback: float):
	if knockback > 0:
		knockback_velocity = (global_position - hitbox_position).normalized() * (knockback + clampi(amount, 0, 10))

func update_animation(state: String, blend_duration: float, speed: float = 1.0) -> void:
	animation.play("%s" % state, blend_duration, speed)
	pass
