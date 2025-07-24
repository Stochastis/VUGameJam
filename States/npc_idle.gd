extends State
class_name NpcIdle

@export var targeter: Targeter
@export var minWaitTime: float = 1
@export var maxWaitTime: float = 5
@export var maxTurnDegrees: float = 45
@export var parent: CharacterBody2D
@export var navAgent: NavigationAgent2D
@export var minDistToWalk: float = 16

func _ready() -> void:
	#Might change this to a more dynamic system in the future if needed for mini state machines and sub-states.
	$StateMachine/NpcIdleStand.minWaitTime = minWaitTime
	$StateMachine/NpcIdleStand.maxWaitTime = maxWaitTime
	$StateMachine/NpcIdleTurn.targeter = targeter
	$StateMachine/NpcIdleTurn.maxTurnDegrees = maxTurnDegrees
	$StateMachine/NpcIdleWalk.targeter = targeter
	$StateMachine/NpcIdleWalk.parent = parent

func enter() -> void:
	$StateMachine.start()

func exit() -> void:
	$StateMachine.stop()

func update(_delta: float) -> void:
	#Keep a watch out for targets
	if targeter.targetingEntity:
		Transitioned.emit(self, "NpcTargeting")
		return
