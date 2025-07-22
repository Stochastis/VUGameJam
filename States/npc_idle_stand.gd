extends State
class_name npc_idle_stand

@export var minWaitTime: float = 1
@export var maxWaitTime: float = 5
@export var targeter: Targeter

func enter():
	$Timer.start(randf_range(minWaitTime, maxWaitTime))

func _on_timer_timeout() -> void:
	var nextState: String = ["npcidleturn", "npcidlewalk"].pick_random()
	Transitioned.emit(self, nextState)

func update(_delta: float) -> void:
	if targeter.targetingEntity:
		$Timer.stop()
		Transitioned.emit(self, "npctargeting")
