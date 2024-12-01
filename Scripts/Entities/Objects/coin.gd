extends StaticBody2D

@export var sfx: AudioStream

func collect_coin(body: Node2D) -> void:
	if body is Player:
		Globals.inventory_add_coins(1)
		MusicPlayer.play_sfx(sfx, global_position)
		queue_free()
