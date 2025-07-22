extends CharacterBody2D

@export var move_speed: float = 75
@export var max_health: int = 100
@export var cooldown: = 1.0
@export var ROTATIONSPEED: float = 1

@onready var target = null
@onready var current_health: int = max_health
@onready var navAgent := $NavigationAgent2D as NavigationAgent2D

var can_attack = true

func is_enemy(entity):
	return entity.is_in_group("Zombies")

func _physics_process(delta):
	if target != null:
		var targetPos: Vector2 = navAgent.get_next_path_position()
		var to_target = (targetPos - global_position).normalized()
		var desired_angle = to_target.angle()
		
		rotation = lerp_angle(rotation, desired_angle, ROTATIONSPEED * delta)
		
		velocity = to_target * move_speed
		move_and_slide()

func _on_nav_timer_timeout() -> void:
	if target != null:
		navAgent.target_position = target.global_position

func _on_proximity_body_entered(body: Node2D) -> void:
	if target == null and not is_enemy(body):
		target = body

func _on_chase_proximity_body_exited(body: Node2D) -> void:
	# We only care if a body left the chase proximity if the body that left is the current target
	# Doesn't matter if other bodies around are leaving the proximity
	if body == target:
		var overlapping_bodies: Array[Area2D] = %Chase_Proximity.get_overlapping_areas()
		
		var nonEnemies: Array[Area2D] = overlapping_bodies.filter(func(overlap): not is_enemy(overlap))
		target = null if nonEnemies.is_empty() else nonEnemies.front()

func _on_attack_proximity_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body == target:
		if can_attack and body.has_node("HealthSystem"):
			body.get_node("HealthSystem").damage(10)
			can_attack = false;
		elif not body.has_node("HealthSystem"):
			printerr("body does not have HealthSystem component")
		get_tree().create_timer(cooldown).timeout.connect(func(): can_attack = true)
