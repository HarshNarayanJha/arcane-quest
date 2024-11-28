class_name State_Walk extends State

@onready var state_idle: State_Idle = $"../State_Idle"
@onready var state_attack: State_Attack = $"../State_Attack"
@onready var state_bow: State_Bow = $"../State_Bow"


## Logic for entering the state
func Enter() -> void:
	player.update_animation("walk", 0.2)
	pass

## Logic for exiting the state
func Exit() -> void:
	pass

## Logic for _process update
func Process(_delta: float) -> State:
	if not player.direction:
		return state_idle

	player.velocity = player.velocity.move_toward(
		player.direction * player.speed,
		player.acceleration * _delta
	)

	if not player.knockback_velocity:
		var target_rotation := player.direction.rotated(PI / 2).angle()
		player.rotation = lerp_angle(player.rotation, target_rotation, player.turn_speed * _delta)

	return null

## Logic for __physics_process update
func Physics(_delta: float) -> State:
	return null

## Logic for input events
func HandleInput(_event: InputEvent) -> State:
	if _event.is_action_pressed("attack") && player.combat_manager.has_sword:
		return state_attack

	if _event.is_action_pressed("aim") && player.combat_manager.has_bow:
		return state_bow

	return null
