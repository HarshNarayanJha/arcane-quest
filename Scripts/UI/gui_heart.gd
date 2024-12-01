class_name GUIHeart extends Control

enum HeartState {
	FULL,
	THREE_QUARTERS,
	HALF,
	QUARTER,
	EMPTY
}
@export var sprite: Sprite2D

@export var heart_full: Texture2D
@export var heart_three_quarters: Texture2D
@export var heart_half: Texture2D
@export var heart_quarters: Texture2D
@export var heart_empty: Texture2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.texture = heart_empty

func set_heart(state: HeartState) -> void:
	match state:
		HeartState.FULL:
			sprite.texture = heart_full
		HeartState.THREE_QUARTERS:
			sprite.texture = heart_three_quarters
		HeartState.HALF:
			sprite.texture = heart_half
		HeartState.QUARTER:
			sprite.texture = heart_quarters
		HeartState.EMPTY:
			sprite.texture = heart_empty
