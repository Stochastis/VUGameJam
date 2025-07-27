extends CharacterBody2D

@export var move_speed: float = 150
@export var playerInteractionArea: Area2D

const MAXFLOAT: float = 10000000000000000

enum InteractionType {
	Use,
	Repair,
	Replace
}

enum RepRepMode {
	Repair,
	Replace,
	None
}

var repRepMode: RepRepMode = RepRepMode.None
var oldRepRepMode: RepRepMode = RepRepMode.None
var repRepObj: Node2D
var oldRepRepObj: Node2D

func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	
	#If needed, get closest repRepObj
	if repRepMode == RepRepMode.Repair:
		repRepObj = closestInteractableArea(InteractionType.Repair)
	elif repRepMode == RepRepMode.Replace:
		repRepObj = closestInteractableArea(InteractionType.Replace)
	
	#If repRepMode or repRepObj changed, clear the timer and start again if needed
	if oldRepRepMode != repRepMode or oldRepRepObj != repRepObj:
		$RepairReplaceTimer.stop()
		if repRepMode == RepRepMode.Repair and repRepObj:
			$RepairReplaceTimer.start(repRepObj.timeToRepair)
		elif repRepMode == RepRepMode.Replace and repRepObj:
			$RepairReplaceTimer.start(repRepObj.timeToReplace)
	oldRepRepMode = repRepMode
	oldRepRepObj = repRepObj
	
	#Debug
	var objStr: String = "null" if not repRepObj else str(repRepObj.get_parent().name)
	print(RepRepMode.keys()[repRepMode] + objStr)

func _physics_process(_delta):
	var input_direction =  Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * move_speed
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("use"):
		var useableArea: Area2D = closestInteractableArea(InteractionType.Use)
		if useableArea:
			interact(useableArea, InteractionType.Use)
		else:
			print("No useableArea found in range")
			
	
	if event.is_action_pressed("repair"):
		beginRepairing()
	if event.is_action_released("repair"):
		stopRepairing()
	if event.is_action_pressed("replace"):
		beginReplacing()
	if event.is_action_released("replace"):
		stopReplacing()

func interact(interactableObj: Node, interactionType: InteractionType) -> void:
	match interactionType:
		InteractionType.Use:
			if interactableObj.has_method("use"):
				interactableObj.use()
			else:
				printerr("Useable Object: " + str(interactableObj.name) + " has no \"use\" method")
		InteractionType.Repair:
			if interactableObj.has_method("repair"):
				interactableObj.repair()
			else:
				printerr("Repairable Object: " + str(interactableObj.name) + " has no \"repair\" method")
		InteractionType.Replace:
			if interactableObj.has_method("replace"):
				interactableObj.replace()
			else:
				printerr("Replaceable Object: " + str(interactableObj.name) + " has no \"replace\" method")

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
	repRepMode = RepRepMode.Repair
	repRepObj = null
func stopRepairing() -> void:
	repRepMode = RepRepMode.None
	repRepObj = null
	if Input.is_action_pressed("replace"):
		beginReplacing()
func beginReplacing() -> void:
	if repRepMode != RepRepMode.Repair:
		repRepMode = RepRepMode.Replace
		repRepObj = null
func stopReplacing() -> void:
	if repRepMode != RepRepMode.Repair:
		repRepMode = RepRepMode.None
		repRepObj = null

func _on_repair_replace_timer_timeout() -> void:
	if repRepObj:
		if repRepMode == RepRepMode.Repair:
			interact(repRepObj, InteractionType.Repair)
			print("Repaired: " + str(repRepObj.get_parent().name))
		elif repRepMode == RepRepMode.Replace:
			interact(repRepObj, InteractionType.Replace)
			print("Replaced: " + str(repRepObj.get_parent().name))
	else:
		push_error("Unexpected timeout of RepRepTimer with a null repRepObj")
