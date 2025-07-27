extends CharacterBody2D

@export var move_speed: float = 150
@export var playerInteractionArea: Area2D

const MAXFLOAT: float = 10000000000000000

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
	if event.is_action_pressed("interact"):
		interact()
	
	if event.is_action_pressed("repair"):
		beginRepairing()
	if event.is_action_released("repair"):
		stopRepairing()
	if event.is_action_pressed("replace"):
		beginReplacing()
	if event.is_action_released("replace"):
		stopReplacing()

func interact() -> void:
	var overlappingAreas = playerInteractionArea.get_overlapping_areas()

	var closestArea: Area2D = closestInteractableArea(overlappingAreas)
	if closestArea != null:
		if closestArea.has_method("interact"):
			closestArea.interact()
		else:
			printerr("InteractableArea has no method with the 'interact' name")
	else:
		print("No interactable area found in range")

func closestInteractableArea(areas: Array[Area2D]) -> Area2D:
	var closestOverlappingArea: Area2D = null
	var distanceToClosest: float = MAXFLOAT
	
	for area in areas:
		if area.name != "Interactable":
			continue
		
		var distanceToArea: float = self.position.distance_to(area.position)
		if distanceToArea < distanceToClosest:
			closestOverlappingArea = area
			distanceToClosest = distanceToArea
	
	return closestOverlappingArea

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
