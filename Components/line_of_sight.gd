extends Node2D
class_name LineOfSight

@export var parent: Node2D
@export var blockingLayers: Array[int]

func has_line_of_sight(target: Node2D) -> bool:
	var mask := 0
	for layer in blockingLayers:
		mask |= 1 << (layer - 1) #Godot layers are 1-indexed in the UI
	
	var query = PhysicsRayQueryParameters2D.create(parent.global_position, target.global_position, mask, [parent, target])
	var result := get_world_2d().direct_space_state.intersect_ray(query)
	return result.is_empty()
