extends NpcTargeting
class_name npc_targeting_zombie

@export var navAgent: NavigationAgent2D
@export var parent: CharacterBody2D
@export var npcTargetingZombieMoveSpeed: float = 20
@export var chaseObservationArea: Area2D
@export var observer: Observer

func physics_update(_delta: float) -> void:
	var nextPathPos: Vector2 = navAgent.get_next_path_position()
	var toNextPath = (nextPathPos - parent.global_position).normalized()
	parent.velocity = toNextPath * npcTargetingZombieMoveSpeed
	parent.move_and_slide()

func reNav() -> void:
	#Re-nav once per second since the target can move
	navAgent.target_position = targeter.targetPosition

func enter() -> void:
	reNav()
	$NavTimer.start()
	observer.observationArea = chaseObservationArea

func exit() -> void:
	$NavTimer.stop()
