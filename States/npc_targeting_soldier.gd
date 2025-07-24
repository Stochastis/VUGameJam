extends NpcTargeting
class_name npc_targeting_soldier

@export var animSprite2D: AnimatedSprite2D

func targetingBehavior() -> void:
	pass

func enter() -> void:
	animSprite2D.set_frame_and_progress(1, 0)

func exit() -> void:
	animSprite2D.set_frame_and_progress(0, 0)
