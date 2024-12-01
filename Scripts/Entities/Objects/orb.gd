extends StaticBody2D

@export var sprite: Sprite2D
@export var orb_texture: Texture2D
@export var light: Light2D
@export var orb_type: Globals.Inventory.ORB_TYPE
@export var sfx: AudioStream

@export var interaction: InteractionArea

func _ready() -> void:
	sprite.texture = orb_texture
	interaction.interact.connect(collect_orb)

	match orb_type:
		Globals.Inventory.ORB_TYPE.RED_ORB:
			light.color = Color.RED
		Globals.Inventory.ORB_TYPE.BLUE_ORB:
			light.color = Color.BLUE
		Globals.Inventory.ORB_TYPE.YELLOW_ORB:
			light.color = Color.YELLOW
		Globals.Inventory.ORB_TYPE.GREEN_ORB:
			light.color = Color.GREEN

func collect_orb() -> void:
	Globals.inventory_set_orb(orb_type)
	MusicPlayer.play_sfx(sfx, global_position)
	queue_free()
