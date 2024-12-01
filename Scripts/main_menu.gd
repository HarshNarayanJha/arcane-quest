extends Control

@export var prologue_scene: PackedScene
@export var credits_scene: PackedScene
@export var help_panel: Control

@export var main_music: AudioStream

@export_category("Button")
@export var play: Button
@export var help: Button
@export var credits: Button
@export var exit: Button
@export var close_help: Button

func _ready() -> void:
	play.pressed.connect(start_game)
	help.pressed.connect(toggle_help)
	credits.pressed.connect(start_credits)
	exit.pressed.connect(exit_game)
	close_help.pressed.connect(toggle_help)

	help_panel.hide()

	MusicPlayer.play_music(main_music)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		help_panel.hide()

func start_game() -> void:
	SceneManager.change_scene(prologue_scene)

func toggle_help() -> void:
	if help_panel.visible:
		help_panel.hide()
	else:
		help_panel.show()

func start_credits() -> void:
	SceneManager.change_scene(credits_scene)

func exit_game() -> void:
	get_tree().quit()
