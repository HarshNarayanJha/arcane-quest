extends Path2D

@export var sprite: Sprite2D
@export var path_follow: PathFollow2D

@export var speed: float
@export var wait_time: float

var target: float

var prev_root: Node2D

func _ready() -> void:
	path_follow.progress_ratio = 0.0
	target = 1.0

func _physics_process(delta: float) -> void:
	
	path_follow.progress_ratio = move_toward(path_follow.progress_ratio, target, speed * delta)
	
	if path_follow.progress_ratio == 1:
		await get_tree().create_timer(wait_time).timeout
		target = 0
	elif path_follow.progress_ratio == 0:
		await get_tree().create_timer(wait_time).timeout
		target = 1


# FIXME: Not Working properly
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		if body.get_parent() != path_follow:
			prev_root = body.get_parent()
			body.get_parent().remove_child(body)
			path_follow.add_child.call_deferred(body)
			#body.position = Vector2.ZERO

# FIXME: Not Working properly
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		if body.get_parent() == path_follow:
			path_follow.remove_child.call_deferred(body)
			#body.position = self.global_position + position
			prev_root.add_child.call_deferred(body)
