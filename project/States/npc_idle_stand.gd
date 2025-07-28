extends State
class_name NpcIdleStand

var minWaitTime: float = 1
var maxWaitTime: float = 5

func enter():
	$Timer.start(randf_range(minWaitTime, maxWaitTime))

func _on_timer_timeout() -> void:
	var nextState: String = ["NpcIdleTurn", "NpcIdleWalk"].pick_random()
	Transitioned.emit(self, nextState)
