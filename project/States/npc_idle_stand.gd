extends State
class_name NpcIdleStand

var minWaitTime: float = 1
var maxWaitTime: float = 5
var collisionShape: CollisionShape2D

func enter():
	collisionShape.disabled = true
	$Timer.start(randf_range(minWaitTime, maxWaitTime))

func _on_timer_timeout() -> void:
	var nextState: String = ["NpcIdleTurn", "NpcIdleWalk"].pick_random()
	Transitioned.emit(self, nextState)

func exit() -> void:
	collisionShape.disabled = false
