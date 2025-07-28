extends CharacterBody2D
class_name Zombie

@export var cooldown: = 1.0

@onready var target = null
@onready var stateMachine: StateMachine = $StateMachine

var can_attack = true
var funnelNode: Node2D

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0:
		queue_free()
