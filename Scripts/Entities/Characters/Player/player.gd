class_name Player extends CharacterBody2D

@export var player_data: PlayerData
@export var state_machine: PlayerStateMachine
@export var interaction_finder: InteractionFinder
@export var combat_manager: CombatManager
@export var sprite: Sprite2D
@export var animation: AnimationPlayer
@export var hurtbox: HurtBox
@export var health: Health

var speed: float
var speed_reduced: float
var acceleration: float
var deceleration: float
var turn_speed: float

var direction := Vector2.ZERO
var knockback_velocity := Vector2.ZERO

var controls_enabled := true

func _ready() -> void:
	assert(player_data != null, "Player Data Not Set!")
	load_data()
	state_machine.init(self)

	hurtbox.took_damage.connect(_took_damage)
	health.died.connect(game_over)

	#unlock_controls()

func load_data() -> void:
	speed = player_data.speed
	speed_reduced = player_data.speed / player_data.speed_reduce_factor
	acceleration = player_data.acceleration
	deceleration = player_data.deceleration
	turn_speed = player_data.turn_speed
	sprite.texture = player_data.player_sprite

func read_input() -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func _physics_process(delta: float) -> void:
	if controls_enabled:
		read_input()

	# overwrite velocity with knockback, if any
	if knockback_velocity.length() > 0:
		velocity = knockback_velocity * speed * delta
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, deceleration * delta)

	move_and_slide()

func _took_damage(amount: int, hitbox_position: Vector2, knockback: float):
	if knockback > 0:
		knockback_velocity = (global_position - hitbox_position).normalized() * (knockback + clampi(amount, 0, 10))

	var shake = procam.get_addons()[0]
	shake.shake()
	await get_tree().create_timer(0.2).timeout
	shake.stop()

func update_animation(state: String, blend_duration: float, speed: float = 1.0) -> void:
	animation.play("Player/%s" % state, blend_duration, speed)
	pass

func lock_controls() -> void:
	controls_enabled = false
	direction = Vector2.ZERO
	velocity = Vector2.ZERO

func unlock_controls() -> void:
	#print("Controls Unlocked")
	controls_enabled = true

func game_over() -> void:
	SceneManager.change_scene("res://Scenes/main_menu.tscn")
	queue_free()
