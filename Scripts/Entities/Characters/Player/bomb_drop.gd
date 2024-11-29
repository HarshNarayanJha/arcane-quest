class_name BombDrop extends Node2D

@export var player: Player
@export var bomb_scene: PackedScene
@export var drop_offset: Vector2
@export var cooldown: Timer

@export_category("Bomb Settings")
@export var time_to_detonate: float
@export var impact_radius: float
@export var impact_time: float

var can_drop: bool: set = set_can_drop

func _ready() -> void:
	cooldown.timeout.connect(set_can_drop.bind(true))
	can_drop = true

func _unhandled_input(event: InputEvent) -> void:
	if not Globals.inventory.has_bomb():
		return

	if event.is_action_pressed("bomb"):
		get_viewport().set_input_as_handled()
		if can_drop:
			print("can Drop Bomb")
			drop_bomb()

func drop_bomb() -> void:
	if not Globals.inventory.has_bomb():
		return

	var point := player.direction + drop_offset
	var bomb: Bomb = bomb_scene.instantiate()
	bomb.time_to_detonate = time_to_detonate
	bomb.impact_radius = impact_radius
	bomb.impact_time = impact_time
	get_tree().root.add_child(bomb)
	bomb.global_position = player.to_global(point)
	cooldown.start()
	set_can_drop(false)

func set_can_drop(val: bool) -> void:
	can_drop = val
