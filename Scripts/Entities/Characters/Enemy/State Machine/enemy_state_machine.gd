class_name EnemyStateMachine extends Node

var states : Array[EnemyState]

var previous_state: EnemyState
var current_state: EnemyState

func _ready() -> void:
	set_process_mode(PROCESS_MODE_DISABLED)

func _process(delta: float) -> void:
	change_state(current_state.Process(delta))
	pass

func _physics_process(delta: float) -> void:
	change_state(current_state.Physics(delta))
	pass

func init(enemy: Enemy) -> void:
	states = []

	for c in get_children():
		if c is EnemyState:
			states.append(c)

	#print_log("INIT: {0}".format(states))

	for s in states:
		s._enemy = enemy
		s.init()

	if states:
		change_state(states[0])
		set_process_mode(PROCESS_MODE_INHERIT)

	#print_log("Changing State: %s -> %s" % [null, states[0].name])

## Change the state to a new state
func change_state(new_state: EnemyState) -> void:
	if not new_state || new_state == current_state:
		return

	if current_state:
		current_state.Exit()
		#print_log("Changing State: %s -> %s" % [current_state.name, new_state.name])

	previous_state = current_state
	current_state = new_state
	new_state.Enter()

func print_log(message: String) -> void:
	print_rich("[color=skyblue]ENEMY STATE MACHINE[/color]: " + message)
