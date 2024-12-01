extends Node

@export var boss_battle_area: Area2D
@export var boss_music: AudioStream
@export var boss: Enemy
@export var laser: Laser

@export var level_dialogue: DialogueResource


var enemy_hit: bool = false

func _ready() -> void:
	laser.hit.connect(check_laser_enemy_hit)
	boss.health.died.connect(enemy_died)
	boss.hurtbox.invincible = true

func play_boss_music(body: Node2D) -> void:
	if body is Player:
		MusicPlayer.play_music(boss_music)
		start_boss_dialogue()
		boss_battle_area.queue_free()

func start_boss_dialogue() -> void:
	DialogueManager.show_dialogue_balloon(level_dialogue, "intro")

func check_laser_enemy_hit(node: Node2D) -> void:
	if enemy_hit:
		laser.hit.disconnect(check_laser_enemy_hit)
		return

	if node.name == "FinalBoss":
		boss.hurtbox.revoke_invincible()
		boss.hurtbox.take_damage(490, boss.global_position + Vector2.DOWN, 500)
		DialogueManager.show_dialogue_balloon(level_dialogue, "laser_done")
		enemy_hit = true

func enemy_died() -> void:
	DialogueManager.show_dialogue_balloon(level_dialogue, "enemy_done")
