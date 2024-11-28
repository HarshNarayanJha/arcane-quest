extends Control

@export var prologue_scene: PackedScene
@export var credits_panel: Control
@export var help_panel: Control

@export_category("Button")
@export var play: Button
@export var help: Button
@export var credits: Button
@export var exit: Button

func _ready() -> void:
	play.pressed.connect(start_game)
	help.pressed.connect(toggle_help)
	credits.pressed.connect(start_credits)
	exit.pressed.connect(exit_game)

	credits_panel.hide()
	help_panel.hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		credits_panel.hide()
		help_panel.hide()

func start_game() -> void:
	Globals.transition_scene(Globals.GameScene.MAIN_MENU, prologue_scene)

func toggle_help() -> void:
	if help_panel.visible:
		help_panel.hide()
	else:
		help_panel.show()

func start_credits() -> void:
	if credits_panel.visible:
		credits_panel.hide()
	else:
		credits_panel.show()

func exit_game() -> void:
	get_tree().quit()
