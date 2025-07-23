extends State
class_name npc_idle_walk

@export var minWaitTime: float = 1
@export var maxWaitTime: float = 5
@export var targeter: Targeter
@export var parent: CharacterBody2D
@export var navAgent: NavigationAgent2D

const DISTANCETOFINALPOINT: float = 27

func enter() -> void:
	#One-time set the navAgent's target to where the NPC is currently looking
	navAgent.target_position = targeter.targetPosition

func update(_delta: float) -> void:
	var nextPathPos: Vector2 = navAgent.get_next_path_position()
	targeter.targetPosition = nextPathPos
	var toNextPath = (nextPathPos - parent.global_position).normalized()
	parent.velocity = toNextPath * parent.move_speed
	parent.move_and_slide()
	
	if parent.position.distance_to(navAgent.target_position) <= DISTANCETOFINALPOINT:
		targeter.resetTarget()
		var nextState: String = ["npcidleturn", "npcidlestand"].pick_random()
		Transitioned.emit(self, nextState)
	
	#Keep a watch out for targets
	if targeter.targetingEntity:
		Transitioned.emit(self, "npctargeting")
