class_name HealthData extends Resource

@export var max_health: int
@export var health: int = max_health

func init() -> void:
	health = max_health

func apply_damage(amount: int) -> void:
	health = clampi(health - amount, 0, max_health)
	
	print(resource_name, " HEALTH_DATA VALUE: ", health)
	
func heal_health(amount: int) -> void:
	health = clampi(health + amount, 0, max_health)
