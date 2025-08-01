extends Node2D
class_name Door

const ACCESSIBLENAVLAYER: int = 2

var open: bool = true
var northSouth: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if open:
		openDoor()
	else:
		closeDoor()
	updateSprite()

func use() -> void:
	if open and $HealthSystem.currHealth > 0:
		closeDoor()
	elif open:
		print("Can't open door because door's health <= 0.")
	else:
		openDoor()
	updateSprite()

func openDoor() -> void:
	open = true
	
	$CollisionShape2D.disabled = true
	$NavigationRegion2D.set_navigation_layer_value(ACCESSIBLENAVLAYER, true)

func closeDoor() -> void:
	open = false
	
	$CollisionShape2D.disabled = false
	$NavigationRegion2D.set_navigation_layer_value(ACCESSIBLENAVLAYER, false)

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0 and not open:
		openDoor()
	updateSprite()

func repair(repairAmount: int) -> void:
	$HealthSystem.heal(repairAmount)

func replace() -> void:
	$HealthSystem.fullHeal()

func updateSprite() -> void:
	if open:
		if northSouth:
			if $HealthSystem.currHealth <= 0:
				$AnimatedSprite2D.set_frame_and_progress(8, 0)
			elif $HealthSystem.currHealth < $HealthSystem.maxHealth:
				$AnimatedSprite2D.set_frame_and_progress(6, 0)
			else:
				$AnimatedSprite2D.set_frame_and_progress(4, 0)
		else:
			if $HealthSystem.currHealth <= 0:
				$AnimatedSprite2D.set_frame_and_progress(9, 0)
			elif $HealthSystem.currHealth < $HealthSystem.maxHealth:
				$AnimatedSprite2D.set_frame_and_progress(7, 0)
			else:
				$AnimatedSprite2D.set_frame_and_progress(5, 0)
	else:
		if northSouth:
			if $HealthSystem.currHealth < $HealthSystem.maxHealth:
				$AnimatedSprite2D.set_frame_and_progress(2, 0)
			else:
				$AnimatedSprite2D.set_frame_and_progress(0, 0)
		else:
			if $HealthSystem.currHealth < $HealthSystem.maxHealth:
				$AnimatedSprite2D.set_frame_and_progress(3, 0)
			else:
				$AnimatedSprite2D.set_frame_and_progress(1, 0)
