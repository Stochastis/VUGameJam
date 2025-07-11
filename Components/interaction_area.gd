extends Area2D

@export var interactableObject: Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func interact() -> void:
	if interactableObject.has_method("interact"):
		interactableObject.interact()
	else:
		printerr("Selected Interactable Object: " + interactableObject.name + " has no method named \"interact\"")
