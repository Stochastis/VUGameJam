extends npc_targeting
class_name npc_targeting_soldier

func targetingBehavior() -> void:
	pass

func enter() -> void:
	$AnimatedSprite2D.set_frame_and_progress(1, 0)

func exit() -> void:
	$AnimatedSprite2D.set_frame_and_progress(0, 0)
