extends Node

#region vars
var player: Player: set = set_player
var inventory: Inventory = Inventory.new():
	set(val):
		pass
	get:
		return inventory
#endregion vars

#region signals
signal player_changed(player: Player)
signal inventory_changed(inventory: Inventory)
#endregion signals

func set_player(instance: Player) -> void:
	player = instance
	player_changed.emit(instance)
	print_log("Player Changed!")

#region inventory_apis
func inventory_add_key(amount: int = 1) -> void:
	inventory.set_keys(inventory.keys + amount)
	inventory_changed.emit(inventory)
	print_log("Got %d Key(s). Now have %d keys(s)" % [amount, inventory.keys])
	
func inventory_use_key(amount: int = 1) -> void:
	inventory.set_keys(inventory.keys - amount)
	inventory_changed.emit(inventory)
	print_log("Used %s Key(s). Now have %s key(s)" % [amount, inventory.keys])
	
func inventory_has_key(atleast: int = 1) -> bool:
	return inventory.keys >= atleast
	
func inventory_set_orb(orb: int) -> void:
	inventory.set_orb(orb)
	inventory_changed.emit(inventory)
	print_log("Got an Orb %d" % orb)
	
func inventory_boss_key() -> void:
	inventory.set_boss_key(true)
	inventory_changed.emit(inventory)
	print_log("Got Boss Key")
	
func inventory_use_boss_key() -> void:
	inventory.set_boss_key(false)
	inventory_changed.emit(inventory)
	print_log("Used Boss Key")
	
#endregion inventory_apis

class Inventory:
	const MAX_KEYS := 8
	
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
	
	func set_keys(amount: int) -> void:
		keys = clamp(amount, 0, MAX_KEYS)
		
	func set_boss_key(have: bool) -> void:
		boss_key = have
		
	func set_orb(orb: int) -> void:
		match orb:
			0: water_orb = true
			1: fire_orb = true
			2: wind_orb = true
			3: earth_orb = true

func print_log(message: String) -> void:
	print_rich("[color=green]GLOBALS[/color]: " + message)
