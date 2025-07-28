extends Area2D

@export var repairableObject: Node
@export var friendlyName: String
@export var timeToRepair: float
@export var repairAmount: float

func repair() -> void:
	if repairableObject.has_method("repair"):
		repairableObject.repair(repairAmount)
	else:
		push_error("Selected Repairable Object: " + repairableObject.name + " has no method named \"repair\"")
