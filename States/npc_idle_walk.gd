extends State
class_name npc_idle_walk

@export var minWaitTime: float = 1
@export var maxWaitTime: float = 5
@export var targeter: Targeter
@export var parent: CharacterBody2D
@export var navAgent: NavigationAgent2D

func enter() -> void:
	navAgent.target_position = targeter.targetPosition
	var nextState: String = ["npcidleturn", "npcidlestand"].pick_random()
	Transitioned.emit(self, nextState)

func update(_delta: float) -> void:
	
	
	if targeter.targetingEntity:
		Transitioned.emit(self, "npctargeting")
