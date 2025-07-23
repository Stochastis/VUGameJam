extends State
class_name npc_idle_walk

@export var minWaitTime: float = 1
@export var maxWaitTime: float = 5
@export var targeter: Targeter

func enter() -> void:
	var nextState: String = ["npcidleturn", "npcidlestand"].pick_random()
	Transitioned.emit(self, nextState)

func update(_delta: float) -> void:
	if targeter.targetingEntity:
		Transitioned.emit(self, "npctargeting")
