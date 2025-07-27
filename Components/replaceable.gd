extends Area2D

@export var replaceableObject: Node
@export var timeToReplace: float

func replace() -> void:
	if replaceableObject.has_method("replace"):
		replaceableObject.replace()
	else:
		printerr("Selected Replaceable Object: " + replaceableObject.name + " has no method named \"replace\"")
