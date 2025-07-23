extends State
class_name npc_targeting

@export var minWaitTime: float = 1
@export var maxWaitTime: float = 5
@export var targeter: Targeter

signal TargetingEntered
signal TargetingExited

func update(_delta: float) -> void:
	if not targeter.targetingEntity:
		Transitioned.emit(self, "npcidlestand")

func enter() -> void:
	TargetingEntered.emit()

func exit() -> void:
	TargetingExited.emit()
