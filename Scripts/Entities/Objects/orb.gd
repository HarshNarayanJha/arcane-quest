extends StaticBody2D

@export var sprite: Sprite2D
@export var orb_texture: Texture2D
@export var orb_type: Globals.Inventory.ORB_TYPE

@export var interaction: InteractionArea

func _ready() -> void:
	sprite.texture = orb_texture
	interaction.interact.connect(collect_orb)

func collect_orb() -> void:
	Globals.inventory_set_orb(orb_type)
	queue_free()
