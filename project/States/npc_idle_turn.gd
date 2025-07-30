extends State
class_name NpcIdleTurn

var targeter: Targeter
var maxTurnDegrees: float = 45
var collisionShape: CollisionShape2D

func enter() -> void:
	collisionShape.disabled = true
	var turnDegrees: float = maxTurnDegrees * randf_range(-1, 1)
	targeter.targetPosition = targeter.global_position + (Vector2.from_angle(targeter.global_rotation + deg_to_rad(turnDegrees)) * 32)
	var nextState: String = ["NpcIdleWalk", "NpcIdleStand"].pick_random()
	Transitioned.emit(self, nextState)

func exit() -> void:
	collisionShape.disabled = false
