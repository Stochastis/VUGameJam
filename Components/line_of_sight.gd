extends Node2D
class_name LineOfSight

@export var parent: Node2D
@export var blockingLayers: Array[int]

var intersectionPoint: Vector2 = Vector2.INF

func has_line_of_sight(node: Node2D = null, point: Vector2 = Vector2.INF) -> bool:
	var mask := 0
	for layer in blockingLayers:
		mask |= 1 << (layer - 1) #Godot layers are 1-indexed in the UI
	
	var query: PhysicsRayQueryParameters2D
	if node:
		if point != Vector2.INF:
			push_warning("has_line_of_sight called with both Node2D and Vector2. Returning from Node2D.")
		query = PhysicsRayQueryParameters2D.create(parent.global_position, node.global_position, mask, [parent, node])
	else:
		if point == Vector2.INF:
			push_error("has_line_of_sight called without Node2D or Vector2.")
		else:
			query = PhysicsRayQueryParameters2D.create(parent.global_position, node.global_position, mask, [parent])
	
	var result := get_world_2d().direct_space_state.intersect_ray(query)
	if result.is_empty():
		intersectionPoint = Vector2.INF
		return true
	else:
		intersectionPoint = result["position"]
		return false
