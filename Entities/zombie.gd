extends CharacterBody2D

@export var cooldown: = 1.0

@onready var target = null

var can_attack = true

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0:
		queue_free()
