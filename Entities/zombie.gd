extends CharacterBody2D

@export var move_speed: float = 75
@export var max_health: int = 100
@export var is_enemy: bool = true

@onready var target = null
@onready var current_health: int = max_health

func _enemy_check(entity):
	return entity.get("is_enemy")
	
func _physics_process(delta):
	if target != null:
		var target_direction = global_position.direction_to(target.global_position)
		velocity = target_direction * move_speed
		look_at(target.position)
		move_and_slide()

func _on_proximity_body_entered(body: Node2D) -> void:
	if _enemy_check(body) == false:
		target = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	var overlapping_bodies = %Chase_Proximity.get_overlapping_areas()
	
	if overlapping_bodies.any(func(): _enemy_check(body)):
		target = overlapping_bodies.filter(_enemy_check(body) == false).front()
	else:
		target = null
