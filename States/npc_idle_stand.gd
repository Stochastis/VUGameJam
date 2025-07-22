extends State
class_name npc_idle_stand

@export var minWaitTime: float = 1
@export var maxWaitTime: float = 5
@export var targeter: Targeter

func enter():
	$Timer.start(randf_range(minWaitTime, maxWaitTime))

func _on_timer_timeout() -> void:
	var nextState: String = ["npc_idle_turn", "npc_idle_walk"].pick_random()
	Transitioned.emit("npc_idle_stand", nextState)

func update(_delta: float) -> void:
	if targeter.targetingEntity:
		$Timer.stop()
		Transitioned.emit("npc_idle_stand", "npc_targeting")
