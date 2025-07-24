extends State
class_name npc_targeting

@export var minWaitTime: float = 1
@export var maxWaitTime: float = 5
@export var targeter: Targeter

func update(_delta: float) -> void:
	if not targeter.targetingEntity:
		Transitioned.emit(self, "npcidle")
	
	targetingBehavior()

func targetingBehavior() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass
