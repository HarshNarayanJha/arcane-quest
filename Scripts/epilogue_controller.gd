extends Node

@export var epilogue_dialogue: DialogueResource
@export var credits_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Globals.player:
		Globals.player.lock_controls()

	DialogueManager.dialogue_ended.connect(load_credits)

	get_tree().create_timer(2).timeout.connect(start_dialogue)

func start_dialogue() -> void:
	if (Globals.inventory.water_orb and
		Globals.inventory.earth_orb and
		Globals.inventory.fire_orb and
		Globals.inventory.wind_orb):
		DialogueManager.show_dialogue_balloon(epilogue_dialogue, "intro")
	else:
		DialogueManager.show_dialogue_balloon(epilogue_dialogue, "intro_no_orb")

func load_credits(resource: DialogueResource) -> void:
	if resource == epilogue_dialogue:
		SceneManager.change_scene(credits_scene)
