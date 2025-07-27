extends NpcTargetLost
class_name NpcTargetLostZombie

@export var parent: CharacterBody2D
@export var navAgent: NavigationAgent2D
@export var observer: Observer
@export var idleObservationArea: Area2D

func enter() -> void:
	if parent.name == "TestZom":
		print("Entering Lost state")
	$ChaseAfterLOSLostTimer.start()
	navAgent.target_position = targeter.targetPosition

func exit() -> void:
	if parent.name == "TestZom":
		print("Exiting Lost state")
	$ChaseAfterLOSLostTimer.stop()
	observer.observationArea = idleObservationArea

func physics_update(_delta: float) -> void:
	var nextPathPos: Vector2 = navAgent.get_next_path_position()
	var toNextPos = (nextPathPos - parent.global_position).normalized()
	parent.velocity = toNextPos * targetLostMoveSpeed
	parent.move_and_slide()

func _on_chase_after_los_lost_timer_timeout() -> void:
	#If we continued chasing for a bit after losing sight and didn't find anything, go back to idle
	Transitioned.emit(self, "NpcIdle")
