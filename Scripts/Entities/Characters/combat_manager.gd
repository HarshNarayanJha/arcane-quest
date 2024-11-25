class_name CombatManager extends Node

@export var left_hand: Node2D
@export var right_hand: Node2D

@export var basic_sword_scene: PackedScene
@export var bow_scene: PackedScene
@export var bow_offset: Vector2 = Vector2(10, 5)

var sword: MeleeWeapon
var bow: BowWeapon

var has_sword: bool = false
var has_bow: bool = false

func _ready() -> void:
	Globals.inventory_changed.connect(inventory_changed)
	
func inventory_changed(inventory: Globals.Inventory) -> void:
	if inventory.has_sword() && not has_sword:
		print("Giving Sword to player in Combat Manager")
		give_sword()
	
	if inventory.has_bow() && not has_bow:
		print("Giving Bow to player in Combat Manager")
		give_bow()

func give_sword():
	var swordNode := basic_sword_scene.instantiate() as MeleeWeapon
	right_hand.add_child.call_deferred(swordNode)
	swordNode.position = Vector2.ZERO
	swordNode.z_index = -1
	sword = swordNode
	has_sword = true
	
func give_bow():
	var bowNode := bow_scene.instantiate() as BowWeapon
	left_hand.add_child.call_deferred(bowNode)
	bowNode.position = bow_offset
	bowNode.z_index = -1
	bow = bowNode
	has_bow = true
	
	disable_bow()
	
func enable_sword() -> void:
	if not has_sword:
		return
		
	sword.hitbox.enable()
	
func disable_sword() -> void:
	if not has_sword:
		return
		
	sword.hitbox.disable()

func show_sword() -> void:
	if not has_sword:
		return
		
	sword.show()
	enable_sword()
	
func hide_sword() -> void:
	if not has_sword:
		return
		
	sword.hide()
	disable_sword()
	
func enable_bow() -> void:
	if not has_bow:
		return
	
	hide_sword()
	bow.enable()
	
func disable_bow() -> void:
	if not has_bow:
		return
	
	show_sword()
	bow.disable()
