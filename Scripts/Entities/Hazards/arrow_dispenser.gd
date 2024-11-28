extends StaticBody2D

enum FIRE_DIRECTION {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

@export var arrow_scene: PackedScene
@export var fire_timer: Timer
@export var fire_rate: float = 0.5
@export var fire_time_margin: float = 1
@export var fire_hint_time: float = 2
@export var fire_hint_distance: float = 2
@export var fire_speed: float = 1000

@export var fire_point: Marker2D
@export var fire_direction: FIRE_DIRECTION

var fire_direction_vector: Vector2

var ready_to_fire := true

func _ready() -> void:
	match fire_direction:
		FIRE_DIRECTION.UP:
			fire_direction_vector = Vector2.UP
		FIRE_DIRECTION.DOWN:
			fire_direction_vector = Vector2.DOWN
		FIRE_DIRECTION.LEFT:
			fire_direction_vector = Vector2.LEFT
		FIRE_DIRECTION.RIGHT:
			fire_direction_vector = Vector2.RIGHT

	fire_timer.set_wait_time(1 / fire_rate + fire_time_margin)
	fire_timer.timeout.connect(fire_arrow)
	fire_timer.start()
	ready_to_fire = true

func _process(delta: float) -> void:
	pass

func fire_arrow() -> void:
	if not ready_to_fire: return

	var arrow := create_arrow()

	await get_tree().create_timer(fire_hint_time, false).timeout
	anticipate_arrow_fire(arrow)

	await get_tree().create_timer(fire_hint_time, false).timeout
	launch_arrow(arrow)

func create_arrow() -> Arrow:
	ready_to_fire = false

	var arrow: Arrow = arrow_scene.instantiate()
	fire_point.add_child(arrow)
	arrow.z_index = -1
	arrow.position = Vector2.ZERO + fire_direction_vector * -10
	arrow.rotation = Vector2.UP.angle_to(fire_direction_vector)

	return arrow

func anticipate_arrow_fire(arrow: Arrow) -> void:
	arrow.position += fire_direction_vector * fire_hint_distance

func launch_arrow(arrow: Arrow) -> void:
	arrow.fire(fire_direction_vector, fire_speed)
	ready_to_fire = true
