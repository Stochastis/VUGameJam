extends State
class_name npc_idle

@export var entity: CharacterBody2D

var move_direction: Vector2
var wander_cycle: float

func randomize():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_cycle = randf_range(1, 3)

func enter():
	randomize()

func update(delta: float):
	if wander_cycle > 0:
		wander_cycle -= delta
	else:
		randomize()

func physics_update(delta: float):
	if entity:
		entity.velocity = move_direction * entity.move_speed
		entity.move_and_slide()
