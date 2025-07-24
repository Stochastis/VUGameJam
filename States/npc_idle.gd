extends State
class_name npc_idle

@export var targeter: Targeter

func enter() -> void:
	$StateMachine.start()
	$StateMachine.set_process(true)
	$StateMachine.set_physics_process(true)

func exit() -> void:
	$StateMachine.set_process(false)
	$StateMachine.set_physics_process(false)

func update(_delta: float) -> void:
	#Keep a watch out for targets
	if targeter.targetingEntity:
		Transitioned.emit(self, "npctargeting")
		return
