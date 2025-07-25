extends Node2D
class_name OuterWall

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0:
		pass
