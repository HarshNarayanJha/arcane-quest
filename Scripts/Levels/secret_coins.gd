extends Node

@export var time: int
@export var coin_scene: PackedScene
@export var markers: Array[Marker2D]

var spawned := false

func spawn_secret_coins(state: bool) -> void:
	if spawned:
		return

	if not state:
		return

	spawned = true
	await get_tree().create_timer(time).timeout

	for m in markers:
		var coin: Node2D = coin_scene.instantiate()
		m.add_child(coin)
