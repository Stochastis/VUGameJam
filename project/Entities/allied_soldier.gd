extends CharacterBody2D

@export var move_speed: float = 20

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0:
		queue_free()
