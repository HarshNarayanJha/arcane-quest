class_name InteractionArea extends Area2D

@export var action_name := "Interact"

signal interact

func enable() -> void:
	set_deferred("monitorable", true)
	set_deferred("monitoring", true)

func disable() -> void:
	set_deferred("monitorable", false)
	set_deferred("monitoring", false)
