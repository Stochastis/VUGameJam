extends State
class_name npc_idle_walk

@export var minWaitTime: float = 1
@export var maxWaitTime: float = 5
@export var targeter: Targeter

func update(_delta: float) -> void:
	if targeter.targetingEntity:
		Transitioned.emit(self, "npctargeting")
