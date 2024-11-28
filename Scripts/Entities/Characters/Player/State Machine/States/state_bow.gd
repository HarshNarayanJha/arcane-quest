class_name State_Bow extends State

@onready var state_idle: State_Idle = $"../State_Idle"
@onready var state_walk: State_Walk = $"../State_Walk"

## Logic for entering the state
func Enter() -> void:
	player.update_animation("bow", 0.1)
	player.combat_manager.enable_bow()
	pass

## Logic for exiting the state
func Exit() -> void:
	player.combat_manager.disable_bow()
	pass

## Logic for _process update
func Process(_delta: float) -> State:

	if not player.combat_manager.has_bow:
		if not player.direction:
			return state_idle
		else:
			return state_walk

	player.velocity = player.velocity.move_toward(
		player.direction * player.speed_reduced,
		player.acceleration * _delta
	)

	return null

## Logic for __physics_process update
func Physics(_delta: float) -> State:
	return null

## Logic for input events
func HandleInput(_event: InputEvent) -> State:
	if not player.controls_enabled:
		return state_idle

	# Cancel arrow by pressing attack button or primary button
	if _event.is_action_pressed("attack") or _event.is_action_pressed("primary"):
		player.combat_manager.bow.cancel_arrow()
		if player.direction:
			return state_walk
		else:
			return state_idle

	if _event.is_action_released("aim"):
		player.combat_manager.bow.shoot_arrow()
		if player.direction:
			return state_walk
		else:
			return state_idle

	return null
