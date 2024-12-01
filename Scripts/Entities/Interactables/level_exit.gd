extends Area2D

@export var this_scene_type: Globals.GameScene
@export var target_scene: PackedScene

func _ready() -> void:
	body_entered.connect(start_transition)

func start_transition(player: Player) -> void:
	if player is not Player:
		return

	SceneManager.change_scene(target_scene)
