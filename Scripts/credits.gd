extends ScrollContainer

@export var credits_music: AudioStream
@export var back: Button
@export var main_menu_path: String

func _ready() -> void:
	back.pressed.connect(go_to_main_menu)
	var twn := get_tree().create_tween()
	twn.tween_property(self, "scroll_vertical", 372, 10).set_delay(3)
	twn.set_ease(Tween.EASE_OUT_IN)
	MusicPlayer.play_music(credits_music)

func go_to_main_menu() -> void:
	SceneManager.change_scene(main_menu_path)
