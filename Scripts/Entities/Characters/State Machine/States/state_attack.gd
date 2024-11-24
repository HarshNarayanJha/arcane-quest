class_name State_Attack extends State

var attacking: bool = false

@onready var state_idle: State_Idle = $"../State_Idle"
@onready var state_walk: State_Walk = $"../State_Walk"

## Logic for entering the state
func Enter() -> void:
	player.update_animation("attack", 0.1, 2.0)
	player.animation.animation_finished.connect(end_attack)
	attacking = true
	pass
	
## Logic for exiting the state
func Exit() -> void:
	player.animation.animation_finished.disconnect(end_attack)
	player.combat_manager.disable_sword()
	attacking = false
	pass

## Logic for _process update
func Process(_delta: float) -> State:
	if not player.combat_manager.has_sword:
		if not player.direction:
			return state_idle
		else:
			return state_walk
			
	player.velocity = player.velocity.move_toward(Vector2.ZERO, player.deceleration * _delta)
	
	if not attacking:
		if not player.direction:
			return state_idle
		else:
			return state_walk
		
	return null
	
## Logic for __physics_process update
func Physics(_delta: float) -> State:
	return null
	
## Logic for input events
func HandleInput(_event: InputEvent) -> State:
	return null

func end_attack(_newAnimName: String) -> void:
	player.combat_manager.disable_sword()
	attacking = false
