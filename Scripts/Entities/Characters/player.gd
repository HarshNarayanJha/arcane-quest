class_name Player extends CharacterBody2D

@export var player_data: PlayerData
@export var state_machine: PlayerStateMachine
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

func _ready() -> void:
	assert(player_data != null, "Player Data Not Set!")
	load_data()
	state_machine.init(self)
	
	hurtbox.took_damage.connect(_took_damage)

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
	read_input()
	
	#if direction:
		#velocity = velocity.move_toward(direction * speed, acceleration * delta)
		
		# if in knockback, don't rotate on will
		#if not knockback_velocity:
			#var target_rotation := direction.rotated(PI / 2).angle()
			#rotation = lerp_angle(rotation, target_rotation, turn_speed * delta)
	#else:
		#velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	# overwrite velocity with knockback, if any
	if knockback_velocity.length() > 0:
		velocity = knockback_velocity * speed * delta
		knockback_velocity = knockback_velocity.move_toward(Vector2.ZERO, deceleration * delta)

	move_and_slide()

func _took_damage(amount: int, hitbox_position: Vector2, knockback: float):
	if knockback > 0:
		knockback_velocity = (global_position - hitbox_position).normalized() * (knockback + clampi(amount, 0, 10))
		
func update_animation(state: String, blend_duration: float, speed: float = 1.0) -> void:
	animation.play("Player/%s" % state, blend_duration, speed)
	pass
		
