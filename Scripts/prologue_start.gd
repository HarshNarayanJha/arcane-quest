extends Node

@export var dialogue_trigger_area: Area2D
@export var dialogue_resource: DialogueResource
@export var dialogue_title: String

func _ready() -> void:
	if dialogue_trigger_area:
		dialogue_trigger_area.body_entered.connect(start_dialogue)

func start_dialogue(body: Node2D) -> void:
	if body is Player or not body:
		DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_title)
		dialogue_trigger_area.queue_free()
