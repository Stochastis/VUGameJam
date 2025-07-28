extends Node

@export var healthSystem: HealthSystem
@export var sprite: Node2D
@export var decayDelay: float
@export var decayInterval: float
@export var decayAmount: int

@onready var main: Main = get_node("/root/Main")

func _ready() -> void:
	if not healthSystem.healthChanged.is_connected(_on_health_system_health_changed):
		healthSystem.healthChanged.connect(_on_health_system_health_changed)

func _on_health_system_health_changed() -> void:
	if healthSystem.currHealth <= 0:
		$DecayDelayTimer.start(decayDelay)
	else:
		$DecayDelayTimer.stop()
		$DecayContributeTimer.stop()

func _on_decay_delay_timer_timeout() -> void:
	_on_decay_contribute_timer_timeout()
	$DecayContributeTimer.start(decayInterval)

func _on_decay_contribute_timer_timeout() -> void:
	main.currStructIntegrity -= decayAmount
	decay_flash()

func decay_flash() -> void:
	if sprite:
		sprite.modulate = Color.DIM_GRAY
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color.WHITE
