extends Node

@export var player: PackedScene
@export var spawn_location: Marker2D

func _ready() -> void:
	assert(player != null, "Player not set to Spawn")
	assert(spawn_location != null, "Spawn Location not set to Spawn")
		
	spawn_player()
	
func spawn_player() -> void:
	var playerNode = player.instantiate() as CharacterBody2D
	get_tree().root.add_child.call_deferred(playerNode)
	playerNode.global_position = spawn_location.global_position
		
