class_name HealthData extends Resource

@export var max_health: int
@export var health: int = max_health

signal health_changed(old: int, new: int)

func init() -> void:
	health = max_health
	health_changed.emit(0, health)

func apply_damage(amount: int) -> void:
	var old_health = health
	health = clampi(health - amount, 0, max_health)
	health_changed.emit(old_health, health)
	#print(health_changed.get_connections())

	#prints(resource_name, "HEALTH_DATA VALUE:", health)

func heal_health(amount: int) -> void:
	var old_health = health
	health = clampi(health + amount, 0, max_health)
	health_changed.emit(old_health, health)
