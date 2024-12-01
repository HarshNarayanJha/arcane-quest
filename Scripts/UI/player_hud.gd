extends CanvasLayer

@export_category("Health")
@export var gui_health_container: Control
@export var gui_heart_scene: PackedScene

@export_category("Interaction")
@export var interaction_container: Control
@export var interaction_label: Label
@export var interaction_button_sprite: Sprite2D

@export_category("Inventory")
@export var keys_label: Label
@export var coins_label: Label

@export var sword_gui: Control
@export var bow_gui: Control
@export var bomb_gui: Control

@export var red_orb_gui: Control
@export var blue_orb_gui: Control
@export var yellow_orb_gui: Control
@export var green_orb_gui: Control

var num_hearts: int
var hearts: Array[GUIHeart] = []

const HEALTH_PER_HEART := 4

func _ready() -> void:
	Globals.player_changed.connect(player_instantiated)
	Globals.inventory_changed.connect(update_inventory)

func player_instantiated(player: Player) -> void:
	num_hearts = player.health.health_data.max_health / HEALTH_PER_HEART
	for c in gui_health_container.get_children():
		gui_health_container.remove_child(c)

	for k in num_hearts:
		var heartControl = gui_heart_scene.instantiate() as GUIHeart
		gui_health_container.add_child(heartControl)
		hearts.push_back(heartControl)

	player.health.health_changed.connect(update_hearts)
	player.interaction_finder.possible_interaction.connect(update_interaction)
	update_inventory(Globals.inventory)

func update_hearts(old: int, new: int) -> void:
	var hearts_to_enable = floor(new / HEALTH_PER_HEART)
	var excess = new % HEALTH_PER_HEART

	for k in hearts.size():
		if k < hearts_to_enable:
			hearts[k].set_heart(GUIHeart.HeartState.FULL)
		elif k == hearts_to_enable:
			match excess:
				3: hearts[k].set_heart(GUIHeart.HeartState.THREE_QUARTERS)
				2: hearts[k].set_heart(GUIHeart.HeartState.HALF)
				1: hearts[k].set_heart(GUIHeart.HeartState.QUARTER)
				0: hearts[k].set_heart(GUIHeart.HeartState.EMPTY)
		else:
			hearts[k].set_heart(GUIHeart.HeartState.EMPTY)

func update_interaction(interaction: InteractionArea) -> void:
	if interaction:
		interaction_container.show()
		interaction_label.text = interaction.action_name
	else:
		interaction_container.hide()
		interaction_label.text = ""

func update_inventory(inventory: Globals.Inventory) -> void:
	keys_label.text = str(inventory.keys)
	coins_label.text = str(inventory.coins)

	if inventory.has_sword():
		sword_gui.show()
	else:
		sword_gui.hide()

	if inventory.has_bow():
		bow_gui.show()
	else:
		bow_gui.hide()

	if inventory.has_bomb():
		bomb_gui.show()
	else:
		bomb_gui.hide()

	if inventory.fire_orb:
		red_orb_gui.show()
	else:
		red_orb_gui.hide()

	if inventory.water_orb:
		blue_orb_gui.show()
	else:
		blue_orb_gui.hide()

	if inventory.wind_orb:
		yellow_orb_gui.show()
	else:
		yellow_orb_gui.hide()

	if inventory.earth_orb:
		green_orb_gui.show()
	else:
		green_orb_gui.hide()
