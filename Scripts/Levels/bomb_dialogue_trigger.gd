extends Node

@export var dialogue: DialogueResource

func trigger_bomb_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, "got_bomb")
