extends State
class_name npc_idle

@export var entity: CharacterBody2D

var move_direction: Vector2
var wander_cycle: float

func randomize_values():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_cycle = randf_range(0, 1.5)

func enter():
	randomize_values()

func update(delta: float):
	if wander_cycle > 0:
		wander_cycle -= delta
	else:
		randomize_values()

func physics_update(_delta: float):
	if entity:
		entity.velocity = move_direction * (entity.move_speed * 0.25)
		entity.move_and_slide()
