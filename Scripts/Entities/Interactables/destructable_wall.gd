extends StaticBody2D

@export var hurtbox: HurtBox
@export var health: Health
@export var sprite: Sprite2D
@export var collision: CollisionShape2D

@export var wall_texture: Texture2D
@export var destroyed_texture: Texture2D

func _ready() -> void:
	sprite.set_texture(wall_texture)
	health.died.connect(destroy_wall)
	
func destroy_wall() -> void:
	collision.set_deferred("disabled", true)
	sprite.set_texture(destroyed_texture)
