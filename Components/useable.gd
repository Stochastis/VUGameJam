extends Area2D

@export var useableObject: Node

func use() -> void:
	if useableObject.has_method("use"):
		useableObject.use()
	else:
		push_error("Selected Useable Object: " + useableObject.name + " has no method named \"use\"")
