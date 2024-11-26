class_name EnemyState extends Node

## Reference to the player holding the state machine
var _enemy: Enemy

func _ready() -> void:
	pass
	
func init() -> void:
	pass

## Logic for entering the state
func Enter() -> void:
	pass
	
## Logic for exiting the state
func Exit() -> void:
	pass

## Logic for _process update
func Process(_delta: float) -> EnemyState:
	return null
	
## Logic for __physics_process update
func Physics(_delta: float) -> EnemyState:
	return null
