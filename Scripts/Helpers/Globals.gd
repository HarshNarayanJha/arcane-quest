extends Node

enum GameScene {
	MAIN_MENU,
	PROLOGUE,
	LEVEL1,
	LEVEL2,
	LEVEL3,
	LEVEL4,
	FINAL,
	CREDITS
}

#region vars
var player: Player: set = set_player
var inventory: Inventory = Inventory.new():
	set(val):
		pass
	get:
		return inventory

var last_scene: GameScene
#endregion vars

#region signals
signal player_changed(player: Player)
signal inventory_changed(inventory: Inventory)
#endregion signals

func set_player(instance: Player) -> void:
	player = instance
	player_changed.emit(instance)
	inventory_changed.emit(inventory)
	#print_log("Player Changed!")

#region inventory_apis

func inventory_add_sword() -> void:
	if inventory.has_sword():
		return

	inventory.set_sword(true)
	inventory_changed.emit(inventory)
	#print_log("Got Sword")

func inventory_add_bow() -> void:
	if inventory.has_bow():
		return

	inventory.set_bow(true)
	inventory_changed.emit(inventory)
	#print_log("Got Bow")

func inventory_add_bomb() -> void:
	if inventory.has_bomb():
		return

	inventory.set_bomb(true)
	inventory_changed.emit(inventory)
	#print_log("Got Bombs")

func inventory_add_key(amount: int = 1) -> void:
	inventory.set_keys(inventory.keys + amount)
	inventory_changed.emit(inventory)
	#print_log("Got %d Key(s). Now have %d keys(s)" % [amount, inventory.keys])

func inventory_use_key(amount: int = 1) -> void:
	inventory.set_keys(inventory.keys - amount)
	inventory_changed.emit(inventory)
	#print_log("Used %s Key(s). Now have %s key(s)" % [amount, inventory.keys])

func inventory_has_key(atleast: int = 1) -> bool:
	return inventory.keys >= atleast

func inventory_add_coins(amount: int = 1) -> void:
	inventory.set_coins(inventory.coins + amount)
	inventory_changed.emit(inventory)
	#print_log("Got %d Coins. Now have %d coinds" % [amount, inventory.coins])

func inventory_set_orb(orb: Inventory.ORB_TYPE) -> void:
	inventory.set_orb(orb)
	inventory_changed.emit(inventory)
	#print_log("Got an Orb %d" % orb)

func inventory_add_boss_key() -> void:
	inventory.set_boss_key(true)
	inventory_changed.emit(inventory)
	#print_log("Got Boss Key")

func inventory_use_boss_key() -> void:
	inventory.set_boss_key(false)
	inventory_changed.emit(inventory)
	#print_log("Used Boss Key")

#endregion inventory_apis

func lock_controls() -> void:
	player.lock_controls()

func unlock_controls() -> void:
	player.unlock_controls()

class Inventory:
	enum ORB_TYPE {
		RED_ORB,
		BLUE_ORB,
		YELLOW_ORB,
		GREEN_ORB
	}

	const MAX_KEYS := 8
	const MAX_COINS := 99

	var keys: int = 0 :
		set = set_keys
	var boss_key: bool = false:
		set = set_boss_key
	var water_orb: bool = false:
		set = set_orb
	var fire_orb: bool = false:
		set = set_orb
	var wind_orb: bool = false:
		set = set_orb
	var earth_orb: bool = false:
		set = set_orb

	var coins: int = 0 :
		set = set_coins

	var sword: bool = false:
		set = set_sword,
		get = has_sword
	var bow: bool = false:
		set = set_bow,
		get = has_bow
	var bomb: bool = false:
		set = set_bomb,
		get = has_bomb

	func set_keys(amount: int) -> void:
		keys = clamp(amount, 0, MAX_KEYS)

	func set_boss_key(have: bool) -> void:
		boss_key = have

	func set_coins(amount: int) -> void:
		coins = clamp(amount, 0, MAX_COINS)

	func set_orb(orb: ORB_TYPE) -> void:
		match orb:
			ORB_TYPE.BLUE_ORB: water_orb = true
			ORB_TYPE.RED_ORB: fire_orb = true
			ORB_TYPE.YELLOW_ORB: wind_orb = true
			ORB_TYPE.GREEN_ORB: earth_orb = true

	func set_sword(have: bool) -> void:
		sword = have

	func has_sword() -> bool:
		return sword

	func set_bow(have: bool) -> void:
		bow = have

	func has_bomb() -> bool:
		return bomb

	func set_bomb(have: bool) -> void:
		bomb = have

	func has_bow() -> bool:
		return bow

func print_log(message: String) -> void:
	print_rich("[color=green]GLOBALS[/color]: " + message)
