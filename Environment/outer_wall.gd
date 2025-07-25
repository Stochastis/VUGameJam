extends Node2D
class_name OuterWall

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0:
		queue_free()

func makeBreakable() -> void:
	$AnimatedSprite2D.set_frame_and_progress(1, 0)
	$BreakableBody.add_to_group("Breakable")
