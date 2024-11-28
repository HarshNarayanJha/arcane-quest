class_name GUIHeart extends Control

enum HeartState {
	FULL,
	HALF,
	EMPTY
}
@export var sprite: Sprite2D

@export var heart_full: Texture2D
@export var heart_half: Texture2D
@export var heart_empty: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = heart_empty

func set_heart(state: HeartState) -> void:
	match state:
		HeartState.FULL:
			sprite.texture = heart_full
		HeartState.HALF:
			sprite.texture = heart_half
		HeartState.EMPTY:
			sprite.texture = heart_empty
