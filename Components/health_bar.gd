extends ProgressBar

@export var healthSystem: Node

func _ready() -> void:
	max_value = healthSystem.maxHealth

func _on_health_system_health_changed() -> void:
	value = healthSystem.currHealth
