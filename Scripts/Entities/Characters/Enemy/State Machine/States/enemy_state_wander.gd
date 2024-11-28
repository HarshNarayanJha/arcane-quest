class_name EnemyState_Wander extends EnemyState

@export var anim_name := "walk"

@export_category("AI")
@export var state_animation_duration: float = 1.0
@export var state_cycles_min := 1
@export var state_cycles_max := 5
@export var next_state: EnemyState

var _timer: float = 0.0
var direction: Vector2

const DIRECTIONS := [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]

## Logic for entering the state
func Enter() -> void:
	_enemy.update_animation(anim_name, 0.1)
	_timer = randi_range(state_cycles_min, state_cycles_max) * state_animation_duration
	_enemy.direction = DIRECTIONS[
		randi_range(0, DIRECTIONS.size() - 1)
	]
	var rand = randi_range(0, 3)
	pass

## Logic for exiting the state
func Exit() -> void:
	pass

## Logic for _process update
func Process(_delta: float) -> EnemyState:
	_timer -= _delta;
	if _timer <= 0:
		return next_state

	_enemy.velocity = _enemy.velocity.move_toward(
		_enemy.direction * _enemy.speed,
		_enemy.acceleration * _delta
	)

	return null

## Logic for __physics_process update
func Physics(_delta: float) -> EnemyState:
	return null

## Logic for input events
func HandleInput(_event: InputEvent) -> EnemyState:
	return null
