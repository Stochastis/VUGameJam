extends Area2D

@export var replaceableObject: Node
@export var friendlyName: String
@export var timeToReplace: float

func replace() -> void:
	if replaceableObject.has_method("replace"):
		replaceableObject.replace()
	else:
		push_error("Selected Replaceable Object: " + replaceableObject.name + " has no method named \"replace\"")
