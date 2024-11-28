extends StaticBody2D

@export var sprite: AnimatedSprite2D
@export var collision: CollisionShape2D

@export var interaction: InteractionArea

func _ready() -> void:
	interaction.interact.connect(pick_key)

func _exit_tree() -> void:
	interaction.interact.disconnect(pick_key)

func pick_key() -> void:
	Globals.inventory_add_key()
	queue_free()
