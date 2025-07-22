extends Node2D
class_name LineOfSight

@export var parent: Node2D
@export var observationArea: Area2D

func has_line_of_sight(target: Node2D, mask: int) -> bool:
	var query = PhysicsRayQueryParameters2D.create(parent.global_position, target.global_position, mask, [parent, target])
	var collision := get_world_2d().direct_space_state.intersect_ray(query)
	if collision.size() > 0:
		print(collision)
	
	return collision.size() == 0
