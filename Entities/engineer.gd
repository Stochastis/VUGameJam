extends CharacterBody2D

@export var move_speed: float = 150
@export var playerInteractionArea: Area2D

const MAXFLOAT: float = 10000000000000000

enum InteractionType {
	Use,
	Repair,
	Replace
}

var repairing: bool = false
var repairingObject: Node2D
var replacing: bool = false
var replacingObject: Node2D

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if repairing:
		print("Repairing: " + str(repairingObject.name))
	elif replacing:
		print("Replacing: " + str(replacingObject.name))

func _physics_process(_delta):
	var input_direction =  Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * move_speed
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		interact(InteractionType.Use)
	
	if event.is_action_pressed("repair"):
		beginRepairing()
	if event.is_action_released("repair"):
		stopRepairing()
	if event.is_action_pressed("replace"):
		beginReplacing()
	if event.is_action_released("replace"):
		stopReplacing()

func interact(interactionType: InteractionType) -> void:
	var interactableArea: Area2D = closestInteractableArea(InteractionType.Use)
	if interactableArea != null:
		match interactionType:
			InteractionType.Use:
				interactableArea.use()
			InteractionType.Repair:
				interactableArea.repair()
			InteractionType.Replace:
				interactableArea.replace()
	else:
		print("No interactable area of type: \"" + str(InteractionType.keys()[interactionType]) + "\" found in range")

func closestInteractableArea(interactionType: InteractionType) -> Area2D:
	var overlappingAreas = playerInteractionArea.get_overlapping_areas()
	var currClosestInteractableArea: Area2D = null
	var distanceToClosest: float = MAXFLOAT
	
	for area in overlappingAreas:
		#Make sure the area has the component we need for this type of interaction
		match interactionType:
			InteractionType.Use:
				if area.name != "Useable":
					continue
			InteractionType.Repair:
				if area.name != "Repairable":
					continue
			InteractionType.Replace:
				if area.name != "Replaceable":
					continue
		
		var distanceToArea: float = self.position.distance_to(area.position)
		if distanceToArea < distanceToClosest:
			currClosestInteractableArea = area
			distanceToClosest = distanceToArea
	
	return currClosestInteractableArea

#Can't do both at the same time. Prioritize repairing over replacing.
func beginRepairing() -> void:
	repairing = true
	repairingObject = self
	if replacing:
		stopReplacing()
func stopRepairing() -> void:
	repairing = false
	repairingObject = null
	if Input.is_action_pressed("replace"):
		beginReplacing()
func beginReplacing() -> void:
	if not repairing:
		replacing = true
		replacingObject = self
func stopReplacing() -> void:
	replacing = false
	replacingObject = null
