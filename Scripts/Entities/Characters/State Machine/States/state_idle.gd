class_name State_Idle extends State

@onready var state_walk: State_Walk = $"../State_Walk"

## Logic for entering the state
func Enter() -> void:
	player.update_animation("idle")
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
	return null
