class_name InteractionArea extends Area2D

@export var action_name := "Interact"

signal interact

func enable() -> void:
	monitorable = true
	monitoring = true

func disable() -> void:
	monitorable = false
	monitoring = false
