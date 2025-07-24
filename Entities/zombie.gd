extends CharacterBody2D

@export var move_speed: float = 20
@export var max_health: int = 100
@export var cooldown: = 1.0
@export var ROTATIONSPEED: float = 1
@export var targeter: Targeter

@onready var target = null
@onready var current_health: int = max_health
@onready var navAgent := $NavigationAgent2D as NavigationAgent2D

var can_attack = true

func _on_attack_proximity_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body == target:
		if can_attack and body.has_node("HealthSystem"):
			body.get_node("HealthSystem").damage(10)
			can_attack = false;
		elif not body.has_node("HealthSystem"):
			printerr("body does not have HealthSystem component")
		get_tree().create_timer(cooldown).timeout.connect(func(): can_attack = true)
