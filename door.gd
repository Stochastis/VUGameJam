extends Node2D

# Not sure if these need to be exported or not
@export var open: bool = true
@export var northSouth: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if open:
		openDoor()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if open:
			closeDoor()
			return
		else:
			openDoor()

func openDoor() -> void:
	open = true
	if northSouth:
		$AnimatedSprite2D.set_frame_and_progress(1, 0)
	else:
		$AnimatedSprite2D.set_frame_and_progress(2, 0)
	$StaticBody2D/CollisionShape2D2.disabled = true

func closeDoor() -> void:
	open = false
	$AnimatedSprite2D.set_frame_and_progress(0, 0)
	$StaticBody2D/CollisionShape2D2.disabled = false
