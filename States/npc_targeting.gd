extends State
class_name NpcTargeting

@export var targeter: Targeter

func update(_delta: float) -> void:
	if not targeter.targetingEntity:
		Transitioned.emit(self, "NpcIdle")
