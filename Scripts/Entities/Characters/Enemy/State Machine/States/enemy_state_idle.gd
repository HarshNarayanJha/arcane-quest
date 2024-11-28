class_name EnemyState_Idle extends EnemyState

#@onready var state_walk: State_Walk = $"../State_Walk"
#@onready var state_attack: State_Attack = $"../State_Attack"
#@onready var state_bow: State_Bow = $"../State_Bow"

@export var anim_name := "idle"

@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1.5
@export var after_idle_state: EnemyState

var _timer: float = 0.0

## Logic for entering the state
func Enter() -> void:
	_enemy.update_animation(anim_name, 0.1)
	_enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	pass

## Logic for exiting the state
func Exit() -> void:
	pass

## Logic for _process update
func Process(_delta: float) -> EnemyState:
	_timer -= _delta;
	if _timer <= 0:
		return after_idle_state

	_enemy.velocity = _enemy.velocity.move_toward(Vector2.ZERO, _enemy.deceleration * _delta)

	return null

## Logic for __physics_process update
func Physics(_delta: float) -> EnemyState:
	return null

## Logic for input events
func HandleInput(_event: InputEvent) -> EnemyState:
	return null
