extends CharacterBody2D

@export var cooldown: = 1.0

@onready var target = null

var can_attack = true

func _on_attack_proximity_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body == target:
		if can_attack and body.has_node("HealthSystem"):
			body.get_node("HealthSystem").damage(10)
			can_attack = false;
		elif not body.has_node("HealthSystem"):
			printerr("body does not have HealthSystem component")
		get_tree().create_timer(cooldown).timeout.connect(func(): can_attack = true)

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0:
		queue_free()
