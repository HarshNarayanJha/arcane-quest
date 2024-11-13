extends Area2D

var areas: Array[Area2D]

var nearest_interaction: InteractionArea = null

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("primary"):
		get_viewport().set_input_as_handled()
		
		if is_instance_valid(nearest_interaction):
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
	areas.push_back(area)

func _on_area_exited(area: Area2D) -> void:
	var index = areas.find(area)
	if index != -1:
		areas.remove_at(index)
