extends ProgressBar

@export var healthSystem: HealthSystem

func _ready() -> void:
	max_value = healthSystem.maxHealth
	visible = false
	if not healthSystem.healthChanged.is_connected(_on_health_system_health_changed):
		var error = healthSystem.healthChanged.connect(_on_health_system_health_changed)
		if error != OK:
			push_error("Failed to connect healthChanged signal")

func _process(delta: float) -> void:
	self.rotation = -get_parent().rotation
	self.global_position = get_parent().global_position + Vector2(-8, -8)

func _on_health_system_health_changed() -> void:
	visible = true
	value = healthSystem.currHealth
