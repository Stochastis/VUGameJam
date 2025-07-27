extends Area2D

@export var interactableObject: Node

func interact() -> void:
	if interactableObject.has_method("interact"):
		interactableObject.interact()
	else:
		printerr("Selected Interactable Object: " + interactableObject.name + " has no method named \"interact\"")
