class_name State_Idle extends State

@onready var state_walk: State_Walk = $"../State_Walk"
@onready var state_attack: State_Attack = $"../State_Attack"
@onready var state_bow: State_Bow = $"../State_Bow"

## Logic for entering the state
func Enter() -> void:
	player.update_animation("idle", 0.1)
	pass

## Logic for exiting the state
func Exit() -> void:
	pass

## Logic for _process update
func Process(_delta: float) -> State:
	if player.direction:
		return state_walk

	player.velocity = player.velocity.move_toward(Vector2.ZERO, player.deceleration * _delta)
	return null

## Logic for __physics_process update
func Physics(_delta: float) -> State:
	return null

## Logic for input events
func HandleInput(_event: InputEvent) -> State:
	if not player.controls_enabled:
		return

	if _event.is_action_pressed("attack") && player.combat_manager.has_sword:
		return state_attack

	if _event.is_action_pressed("aim") && player.combat_manager.has_bow:
		return state_bow

	return null
