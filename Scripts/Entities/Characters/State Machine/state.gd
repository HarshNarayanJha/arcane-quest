class_name State extends Node

## Reference to the player holding the state machine
static var player: Player

func _ready() -> void:
	pass

## Logic for entering the state
func Enter() -> void:
	pass
	
## Logic for exiting the state
func Exit() -> void:
	pass

## Logic for _process update
func Process(_delta: float) -> State:
	return null
	
## Logic for __physics_process update
func Physics(_delta: float) -> State:
	return null
	
## Logic for input events
func HandleInput(_event: InputEvent) -> State:
	return null
