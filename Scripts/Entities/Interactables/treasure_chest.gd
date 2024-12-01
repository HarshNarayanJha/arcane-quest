class_name TreasureChest extends StaticBody2D

enum ChestType {
	COINS,
	SWORD,
	BOW,
	BOMB,
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

@export_category("SFX")
@export var got_item_sfx: AudioStream
@export var coin_collected_sfx: AudioStream

signal chest_opened_type(chest_type: ChestType)
signal chest_opened

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
			Globals.inventory_add_coins(num_coins)
			MusicPlayer.play_sfx(coin_collected_sfx, Globals.player.global_position)
		ChestType.SWORD:
			Globals.inventory_add_sword()
			MusicPlayer.play_sfx(got_item_sfx, Globals.player.global_position)
		ChestType.BOW:
			Globals.inventory_add_bow()
			MusicPlayer.play_sfx(got_item_sfx, Globals.player.global_position)
		ChestType.BOMB:
			Globals.inventory_add_bomb()
			MusicPlayer.play_sfx(got_item_sfx, Globals.player.global_position)
		ChestType.KEY:
			Globals.inventory_add_key()
			MusicPlayer.play_sfx(got_item_sfx, Globals.player.global_position)
		ChestType.BOSS_KEY:
			Globals.inventory_add_boss_key()
			MusicPlayer.play_sfx(got_item_sfx, Globals.player.global_position)

	chest_opened_type.emit(chest_type)
	chest_opened.emit()

	# TEMP: Remove this
	queue_free()

func disable() -> void:
	hide()
	collison.set_deferred("disabled", true)
	interaction.disable()

func enable() -> void:
	show()
	collison.set_deferred("disabled", false)
	interaction.enable()

func disable_trigger_body(body: Node2D) -> void:
	if body is Player:
		disable()

func enable_trigger_body(body: Node2D) -> void:
	if body is Player:
		enable()
	interaction.enable()
