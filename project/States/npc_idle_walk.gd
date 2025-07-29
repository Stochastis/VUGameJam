extends State
class_name NpcIdleWalk

#Inheriting from NpcIdle super-state
var targeter: Targeter
var parent: CharacterBody2D
var idleWalkMoveSpeed: float

const MINDISTTOWALK: float = 32
const MINDISTFROMPOINT: float = 8

func enter() -> void:
	#targeter.resetTarget()
	var firstIntersectionPoint: Vector2 = first_intersection_point(targeter.targetPosition)
	targeter.targetPosition = firstIntersectionPoint
	
	if firstIntersectionPoint.distance_to(parent.global_position) < MINDISTTOWALK:
		var nextState: String = ["NpcIdleTurn", "NpcIdleStand"].pick_random()
		Transitioned.emit(self, nextState)
		return
	
	$WalkTimer.start()

func exit() -> void:
	$WalkTimer.stop()

func physics_update(_delta: float) -> void:
	var toNextPath = (targeter.targetPosition - parent.global_position).normalized()
	parent.velocity = toNextPath * idleWalkMoveSpeed
	parent.move_and_slide()
	
	parent.global_position.distance_to(targeter.targetPosition)
	if parent.global_position.distance_to(targeter.targetPosition) < MINDISTFROMPOINT:
		var nextState: String = ["NpcIdleTurn", "NpcIdleStand"].pick_random()
		Transitioned.emit(self, nextState)

func first_intersection_point(target: Vector2) -> Vector2:
	var query = PhysicsRayQueryParameters2D.create(parent.global_position, target, parent.collision_mask, [parent])
	var result := parent.get_world_2d().direct_space_state.intersect_ray(query)
	if result.is_empty():
		return target
	return result["position"]

func _on_walk_timer_timeout() -> void:
	var nextState: String = ["NpcIdleTurn", "NpcIdleStand"].pick_random()
	Transitioned.emit(self, nextState)
