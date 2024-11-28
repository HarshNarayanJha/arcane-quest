class_name TreasureChest extends StaticBody2D

enum ChestType {
	COINS,
	SWORD,
	BOW,
	KEY,
	BOSS_KEY
}

@export var chest_type: ChestType
@export var num_coins: int = 0

@export var sprite: Sprite2D
@export var collison: CollisionShape2D
@export var interaction: InteractionArea
@export var is_open: bool = false

@export var open_sprite: Texture2D
@export var close_sprite: Texture2D

signal chest_opened(chest_type: ChestType)

func _ready() -> void:
	interaction.interact.connect(open_chest)
	sprite.set_texture(close_sprite)
	if is_open:
		sprite.set_texture(open_sprite)

func _exit_tree() -> void:
	interaction.interact.disconnect(open_chest)

func open_chest() -> void:
	if is_open:
		return

	is_open = true
	sprite.texture = open_sprite

	match chest_type:
		ChestType.COINS:
			#give him coins
			pass
		ChestType.SWORD:
			Globals.inventory_add_sword()
		ChestType.BOW:
			Globals.inventory_add_bow()
		ChestType.KEY:
			Globals.inventory_add_key()
		ChestType.BOSS_KEY:
			Globals.inventory_add_boss_key()

	chest_opened.emit(chest_type)

	# TEMP: Remove this
	queue_free()
