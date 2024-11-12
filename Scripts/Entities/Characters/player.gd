class_name Player extends CharacterBody2D

@export var player_data: PlayerData
@export var sprite: Sprite2D

var speed: float
var acceleration: float
var deceleration: float

var direction := Vector2.ZERO

func _ready() -> void:
	assert(player_data != null, "Player Data Not Set!")
	load_data()

func load_data() -> void:
	speed = player_data.speed
	acceleration = player_data.acceleration
	deceleration = player_data.deceleration
	sprite.texture = player_data.player_sprite

func read_input() -> void:
	direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

func _physics_process(delta: float) -> void:
	read_input()
	
	if direction:
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)

	move_and_slide()
