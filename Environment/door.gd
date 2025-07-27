extends Node2D
class_name Door

var open: bool = true
var northSouth: bool = true
@export var northSouthNavRegion: NavigationRegion2D
@export var eastWestNavRegion: NavigationRegion2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#To set the correct sprite frame
	if open:
		openDoor()
	else:
		closeDoor()

func interact() -> void:
	if open and $HealthSystem.currHealth > 0:
		closeDoor()
	elif open:
		print("Can't open door because door's health is 0 or less.")
	else:
		openDoor()

func openDoor() -> void:
	open = true
	if northSouth:
		#$NavigationRegion2DNS.enabled = true
		$AnimatedSprite2D.set_frame_and_progress(2, 0)
	else:
		#$NavigationRegion2DEW.enabled = true
		$AnimatedSprite2D.set_frame_and_progress(3, 0)
	$CollisionShape2D.disabled = true

func closeDoor() -> void:
	open = false
	if northSouth:
		#$NavigationRegion2DNS.enabled = false
		$AnimatedSprite2D.set_frame_and_progress(0, 0)
	else:
		#$NavigationRegion2DEW.enabled = false
		$AnimatedSprite2D.set_frame_and_progress(1, 0)
	$CollisionShape2D.disabled = false

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0:
		openDoor()
		if northSouth:
			$AnimatedSprite2D.set_frame_and_progress(4, 0)
		else:
			$AnimatedSprite2D.set_frame_and_progress(5, 0)
