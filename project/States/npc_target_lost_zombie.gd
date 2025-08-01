extends NpcTargetLost
class_name NpcTargetLostZombie

@onready var focus_area: Area2D = $"../../Focus_Area"

@export var parent: CharacterBody2D
@export var observer: Observer
@export var idleObservationArea: Area2D
@export var attackCollisionShape: CollisionShape2D
@export var idleObservingCollisionShape: CollisionShape2D
@export var chaseObservingCollisionShape: CollisionShape2D

func enter() -> void:
	if parent.name == "TestZom":
		print("Entering Lost state")
	
	attackCollisionShape.disabled = true
	idleObservingCollisionShape.disabled = true
	chaseObservingCollisionShape.disabled = false
	$ChaseAfterLOSLostTimer.start()

func exit() -> void:
	if parent.name == "TestZom":
		print("Exiting Lost state")
	
	attackCollisionShape.disabled = true
	idleObservingCollisionShape.disabled = false
	chaseObservingCollisionShape.disabled = true
	$ChaseAfterLOSLostTimer.stop()
	observer.observationArea = focus_area

func physics_update(_delta: float) -> void:
	var toTarget = (targeter.targetPosition - parent.global_position).normalized()
	parent.velocity = toTarget * targetLostMoveSpeed
	parent.move_and_slide()

func _on_chase_after_los_lost_timer_timeout() -> void:
	#If we continued chasing for a bit after losing sight and didn't find anything, go back to idle
	Transitioned.emit(self, idleState)
