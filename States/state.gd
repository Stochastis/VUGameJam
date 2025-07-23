extends Node
class_name State

signal Transitioned(State, String)

func enter() -> void:
	pass

func exit() -> void:
	pass
	
func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
