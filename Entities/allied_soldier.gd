extends CharacterBody2D

@export var move_speed: float = 20

func _on_npc_targeting_targeting_entered() -> void:
	$AnimatedSprite2D.set_frame_and_progress(1, 0)

func _on_npc_targeting_targeting_exited() -> void:
	$AnimatedSprite2D.set_frame_and_progress(0, 0)
