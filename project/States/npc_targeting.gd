extends State
class_name NpcTargeting

@export var targeter: Targeter

#Default targeting behavior that can be overriden by inheriting classes if necessary.
func update(_delta: float) -> void:
	if not targeter.targetingEntity:
		Transitioned.emit(self, "NpcTargetLost")
