extends CharacterBody2D

@export var move_speed: float = 75
@export var max_health: int = 100
@export var cooldown: = 1.0

@onready var target = null
@onready var current_health: int = max_health

var can_attack = true

func _enemy_check(entity):
	return entity.is_in_group("Enemies")

func _take_damage(amount: int) -> void:
	current_health -= amount

func _physics_process(_delta):
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
#
func _on_attack_proximity_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body == target:
		if can_attack:
			body._take_damage(10)
			can_attack = false;
		get_tree().create_timer(cooldown).timeout.connect(func(): can_attack = true)
