extends State
class_name NpcTargetLost

@export var targeter: Targeter
@export var targetLostMoveSpeed: float
@export var idleState: NpcIdle
@export var targetingState: NpcTargeting

#Default target lost behavior that can be overriden by inheriting classes if necessary.
func enter() -> void:
	Transitioned.emit(self, idleState)

func update(_delta: float) -> void:
	#If we regain line of sight to a target, go back to the targeting state
	if targeter.targetingEntity:
		Transitioned.emit(self, targetingState)
