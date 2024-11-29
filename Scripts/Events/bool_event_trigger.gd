class_name BoolEventTrigger extends Node

signal trigger(val: bool)

func make_trigger(val: bool) -> void:
	trigger.emit(val)
