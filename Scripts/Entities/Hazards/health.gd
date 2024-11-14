class_name Health extends Node

@export var health_data: HealthData

signal health_changed(old_health: int, new_health: int)
signal died

func _ready() -> void:
	health_data.init()
	health_changed.emit(health_data.health, health_data.health)
	
func apply_damage(amount: int) -> void:
	if (health_data.health <= 0): return
	
	var old_health = health_data.health
	health_data.apply_damage(amount)
	
	health_changed.emit(old_health, health_data.health)
	
	print(name, "'s Health changed! From ", old_health, "->", health_data.health)
	
	if (health_data.health <= 0):
		print("Oopsie!", name, "died!")
		died.emit()
	
func heal_health(amount: int) -> void:
	var old_health = health_data.health
	health_data.heal_health(amount)
	
	health_changed.emit(old_health, health_data.health)
