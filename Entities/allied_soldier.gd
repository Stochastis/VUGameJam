extends CharacterBody2D

@export var move_speed: float = 100
@export var observer: Observer
@export var targeter: Targeter
@export var ROTATIONSPEED: float = 8

func _ready() -> void:
	targeter.targetPosition = position + Vector2.from_angle(rotation)

func _process(delta: float) -> void:
	var to_target = (targeter.targetPosition - position).normalized()
	var desired_angle = to_target.angle()
	rotation = lerp_angle(rotation, desired_angle, ROTATIONSPEED * delta)
	
	if targeter.targetingEntity:
		$AnimatedSprite2D.set_frame_and_progress(1, 0)
	else:
		$AnimatedSprite2D.set_frame_and_progress(0, 0)
