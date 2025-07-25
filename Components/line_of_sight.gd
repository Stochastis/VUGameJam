extends Node2D
class_name LineOfSight

@export var parent: Node2D
@export var blockingLayers: Array[int]

func has_line_of_sight(target: Node2D) -> bool:
	#Create the combined bitmask
	var mask := 0
	for layer in blockingLayers:
		mask |= 1 << (layer - 1) #Godot layers are 1-indexed in the UI
	
	var pointToLookAt: Vector2
	var targetPoint: TargetPoint = target.get_node_or_null("../TargetPoint")
	if targetPoint != null:
		pointToLookAt = targetPoint.global_position
	else:
		pointToLookAt = target.global_position
	
	var query = PhysicsRayQueryParameters2D.create(parent.global_position, pointToLookAt, mask, [parent, target])
	var result := get_world_2d().direct_space_state.intersect_ray(query)
	return result.is_empty()
