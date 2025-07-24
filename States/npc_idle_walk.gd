extends State
class_name npc_idle_walk

@export var targeter: Targeter
@export var parent: CharacterBody2D
@export var navAgent: NavigationAgent2D
@export var minDistToWalk: float = 16

func enter() -> void:
	targeter.resetTarget()
	var firstIntersectionPoint: Vector2 = first_intersection_point(targeter.targetPosition)
	
	if firstIntersectionPoint.distance_to(parent.global_position) < minDistToWalk:
		var nextState: String = ["npcidleturn", "npcidlestand"].pick_random()
		Transitioned.emit(self, nextState)
		return
	
	#One-time set the navAgent's target to where the NPC is currently looking
	if not navAgent.navigation_finished.is_connected(_on_navigation_agent_2d_navigation_finished):
		navAgent.navigation_finished.connect(_on_navigation_agent_2d_navigation_finished)
	navAgent.target_position = firstIntersectionPoint

#Disconnect from signal so the func isn't running when navAgent is being used elsewhere
func exit() -> void:
	if navAgent.navigation_finished.is_connected(_on_navigation_agent_2d_navigation_finished):
		navAgent.navigation_finished.disconnect(_on_navigation_agent_2d_navigation_finished)

func update(_delta: float) -> void:
	var nextPathPos: Vector2 = navAgent.get_next_path_position()
	targeter.targetPosition = nextPathPos
	var toNextPath = (nextPathPos - parent.global_position).normalized()
	parent.velocity = toNextPath * parent.move_speed
	parent.move_and_slide()

func _on_navigation_agent_2d_navigation_finished():
	targeter.resetTarget()
	var nextState: String = ["npcidleturn", "npcidlestand"].pick_random()
	Transitioned.emit(self, nextState)

func first_intersection_point(target: Vector2) -> Vector2:
	var query = PhysicsRayQueryParameters2D.create(parent.global_position, target, parent.collision_mask, [parent])
	var result := parent.get_world_2d().direct_space_state.intersect_ray(query)
	if result.is_empty():
		return target
	return result["position"]
