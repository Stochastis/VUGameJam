extends State
class_name npc_idle_turn

@export var targeter: Targeter
@export var maxTurnDegrees: float = 45

func enter() -> void:
	var turnDegrees: float = maxTurnDegrees * randf_range(-1, 1)
	targeter.targetPosition = targeter.global_position + (Vector2.from_angle(targeter.global_rotation + deg_to_rad(turnDegrees)) * 32)
	var nextState: String = ["npcidlewalk", "npcidlestand"].pick_random()
	Transitioned.emit(self, nextState)

func update(_delta: float) -> void:
	if targeter.targetingEntity:
		Transitioned.emit(self, "npctargeting")
