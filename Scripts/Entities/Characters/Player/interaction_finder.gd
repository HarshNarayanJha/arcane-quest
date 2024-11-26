extends Area2D

@export var player: Player

var areas: Array[Area2D]

var nearest_interaction: InteractionArea = null

func _ready() -> void:
	self.area_entered.connect(_on_area_entered)
	self.area_exited.connect(_on_area_exited)
	
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("primary"):
		get_viewport().set_input_as_handled()
		
		if is_instance_valid(nearest_interaction) and areas.has(nearest_interaction as Area2D):
			nearest_interaction.interact.emit()

func check_nearest_interaction() -> void:
	var shortest_distance: float = INF
	for area in areas:
		var distance := area.global_position.distance_squared_to(global_position)
		if distance < shortest_distance:
			shortest_distance = distance
			nearest_interaction = area as InteractionArea
			
func _process(delta: float) -> void:
	check_nearest_interaction()

func _on_area_entered(area: Area2D) -> void:
	if area is InteractionArea:
		areas.push_back(area)

func _on_area_exited(area: Area2D) -> void:
	var index = areas.find(area)
	if index != -1:
		if areas[index] == nearest_interaction:
			nearest_interaction = null
		areas.remove_at(index)
		
func _on_body_entered(body: Node2D) -> void:
	# TEMP TODO: Push Code here
	if body is Crate:
		body.push_direction = player.direction
	
func _on_body_exited(body: Node2D) -> void:
	if body is Crate:
		body.push_direction =Vector2.ZERO
