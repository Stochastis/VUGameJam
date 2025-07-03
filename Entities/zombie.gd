extends CharacterBody2D

@export var move_speed: float = 75
@export var max_health: int = 100
@export var focus_range: int = 400

@onready var target = %engineer

var current_health: int = max_health

func _physics_process(delta):
	var target_direction = global_position.direction_to(target.global_position)
	velocity = target_direction * move_speed
	look_at(target.position)
	move_and_slide()
	
