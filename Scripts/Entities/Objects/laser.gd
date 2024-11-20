extends StaticBody2D

@export var sprite: Sprite2D
@export var raycast: RayCast2D
@export var line: Line2D
@export var particles: GPUParticles2D
@export_flags_2d_physics var mirror_layer: int

@export var bounces := 5

const MAX_LENGTH := 1000

func _ready() -> void:
	pass
	#print(raycast.collision_mask)
	#raycast.set_collision_mask_value(mirror_layer, true)
	
func _draw() -> void:
	draw_circle(raycast.position, 10, Color.AQUAMARINE)
	var normal_end_point = raycast.get_collision_point() + raycast.get_collision_normal() * 80.0
	draw_line(to_local(raycast.get_collision_point()), to_local(normal_end_point), Color.GREEN, 10)

func _process(delta: float) -> void:
	queue_redraw()
	
	# clear the laser and add origin
	line.clear_points()
	line.add_point(Vector2.ZERO)
	
	raycast.global_position = line.global_position
	raycast.target_position = Vector2(MAX_LENGTH, 0)
	#raycast.target_position = (get_local_mouse_position() - line.position).normalized() * MAX_LENGTH
	raycast.force_raycast_update()
	
	for k in bounces:
		if not raycast.is_colliding():
			var pt = raycast.position + raycast.target_position
			line.add_point(pt)
			#particles.emitting = false
			break
			
		var coll = raycast.get_collider()
		var pt = raycast.get_collision_point()
		
		line.add_point(line.to_local(pt))
		
		if not coll is CollisionObject2D:
			break
			
		var col: CollisionObject2D = coll
		
		if not col.get_collision_layer_value(log(mirror_layer) / log(2) + 1):
			break
			
		var normal = raycast.get_collision_normal()
		if normal == Vector2.ZERO:
			break
			
		particles.global_position = pt
		particles.emitting = true
			
		raycast.global_position = pt
		raycast.target_position = raycast.target_position.bounce(normal.rotated(-global_rotation))
		raycast.force_raycast_update()
