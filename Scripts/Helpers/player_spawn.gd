extends Node

@export var player: PackedScene
@export var spawn_location: Marker2D
@export var level_music: AudioStream

func _ready() -> void:
	assert(player != null, "Player not set to Spawn")
	assert(spawn_location != null, "Spawn Location not set to Spawn")

	spawn_player()

	MusicPlayer.play_music(level_music)

func spawn_player() -> void:
	var playerNode = player.instantiate() as Player
	get_parent().add_child.call_deferred(playerNode)
	playerNode.global_position = spawn_location.global_position

	Globals.set_player(playerNode)
