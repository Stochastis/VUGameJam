extends Node
class_name State

#Can ignore the warning since this is an abstract class
@warning_ignore("unused_signal")
signal Transitioned(State, String)

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
