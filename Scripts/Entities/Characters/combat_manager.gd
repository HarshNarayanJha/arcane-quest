class_name CombatManager extends Node

@export var left_hand: Node2D
@export var right_hand: Node2D

@export var basic_sword_scene: PackedScene
@export var bow_scene: PackedScene

var sword: MeleeWeapon

var has_sword: bool = false
var has_bow: bool = false

func _ready() -> void:
	Globals.inventory_changed.connect(inventory_changed)
	
func inventory_changed(inventory: Globals.Inventory) -> void:
	if inventory.has_sword() && not has_sword:
		print("Giving Sword to player in Combat Manager")
		give_sword()
	
	if inventory.has_bow() && not has_bow:
		give_bow()

func give_sword():
	var swordNode = basic_sword_scene.instantiate() as MeleeWeapon
	right_hand.add_child.call_deferred(swordNode)
	swordNode.position = Vector2.ZERO
	swordNode.z_index = -1
	sword = swordNode
	has_sword = true
	
func enable_sword() -> void:
	if not has_sword:
		return
		
	sword.hitbox.enable()
	
func disable_sword() -> void:
	if not has_sword:
		return
		
	sword.hitbox.disable()
	
func give_bow():
	# TODO: Bow Class
	var bowNode = bow_scene.instantiate() as MeleeWeapon
	get_parent().add_child.call_deferred(bowNode)
	bowNode.global_position = right_hand.global_position
	has_bow = true
