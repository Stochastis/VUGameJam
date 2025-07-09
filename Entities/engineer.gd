extends CharacterBody2D

@export var move_speed: float = 150
@export var max_health: int = 100

var current_health: int = max_health

const MAXFLOAT: float = 10000000000000000

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		interact()

func _physics_process(_delta):
	var input_direction =  Input.get_vector("left", "right", "up", "down")
	
	velocity = input_direction * move_speed
	
	move_and_slide()
	
	get_node("pivotPoint").look_at(get_global_mouse_position())

func interact() -> void:
	var overlappingAreas = $PlayerInteractionArea.get_overlapping_areas()

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
		if area.name != "InteractionArea":
			continue

		var distanceToArea: float = self.position.distance_to(area.position)
		if distanceToArea < distanceToClosest:
			closestOverlappingArea = area
			distanceToClosest = distanceToArea

	return closestOverlappingArea
