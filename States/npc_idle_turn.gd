extends State
class_name npc_idle_turn

@export var minWaitTime: float = 1
@export var maxWaitTime: float = 5
@export var targeter: Targeter

func update(_delta: float) -> void:
	if targeter.targetingEntity:
		Transitioned.emit("npc_idle_turn", "npc_targeting")
