extends CharacterBody2D

@export var move_speed: float = 20

func _on_npc_targeting_targeting_entered() -> void:
	$AnimatedSprite2D.set_frame_and_progress(1, 0)

func _on_npc_targeting_targeting_exited() -> void:
	$AnimatedSprite2D.set_frame_and_progress(0, 0)

func _process(delta: float) -> void:
	if name == "AlliedSoldier" and $StateMachine.current_state.name == "NpcIdleWalk":
		print("Target: " + str($NavigationAgent2D.target_position))
		print("Self: " + str(global_position))
		print(str($NavigationAgent2D.distance_to_target()) + " away")
