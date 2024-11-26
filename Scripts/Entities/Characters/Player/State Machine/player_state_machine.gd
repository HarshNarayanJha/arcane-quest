class_name PlayerStateMachine extends Node

var states : Array[State]

var previous_state: State
var current_state: State

func _ready() -> void:
	set_process_mode(PROCESS_MODE_DISABLED)

func _process(delta: float) -> void:
	change_state(current_state.Process(delta))
	pass
	
func _physics_process(delta: float) -> void:
	change_state(current_state.Physics(delta))
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	change_state(current_state.HandleInput(event))
	pass
	
func init(player: Player) -> void:
	states = []
	
	for c in get_children():
		if c is State:
			states.append(c)
	print_log("INIT: {}".format(states))
			
	if states:
		states[0].player = player
		change_state(states[0])
		set_process_mode(PROCESS_MODE_INHERIT)
		
	print_log("Changing State: %s -> %s" % [null, states[0].name])
	
## Change the state to a new state
func change_state(new_state: State) -> void:
	if not new_state || new_state == current_state:
		return
	
	if current_state:
		current_state.Exit()
		print_log("Changing State: %s -> %s" % [current_state.name, new_state.name])
	
	previous_state = current_state
	current_state = new_state
	new_state.Enter()
	
func print_log(message: String) -> void:
	print_rich("[color=skyblue]PLAYER STATE MACHINE[/color]: " + message)
