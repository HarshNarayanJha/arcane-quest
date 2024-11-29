extends Node

@export var dialogue_trigger_area: Area2D
@export var dialogue_resource: DialogueResource
@export var dialogue_title: String

@export var dialogue_trigger_event: EventTrigger

func _ready() -> void:
	if dialogue_trigger_area:
		dialogue_trigger_area.body_entered.connect(start_dialogue_area)
	if dialogue_trigger_event:
		dialogue_trigger_event.trigger.connect(start_dialogue)

func start_dialogue_area(body: Node2D) -> void:
	if body is Player or not body:
		start_dialogue()
		dialogue_trigger_area.queue_free()

func start_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(dialogue_resource, dialogue_title)
