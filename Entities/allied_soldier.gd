extends CharacterBody2D

@export var lineOfSight: Node2D

func _process(delta: float) -> void:
	if lineOfSight.observingEntity:
		$AnimatedSprite2D.set_frame_and_progress(1, 0)
	else:
		$AnimatedSprite2D.set_frame_and_progress(0, 0)
