extends Node2D
class_name RepairableObject

@export var max_health := 100
@export var decay_rate := 5
var health := max_health
var decaying := true

func _ready():
	add_to_group("repairables")

func _process(delta):
	if decaying:
		health -= decay_rate * delta
		if health < 0:
			health = 0
			Global.decay_meter += 1  # increment global decay
		update_visual()

func repair(full: bool):
	if full:
		health = max_health
	else:
		health += 20
		if health > max_health:
			health = max_health
	update_visual()

func update_visual():
	# Example: fade color based on health
	var sprite = $Sprite2D
	sprite.modulate = Color(1.0, health / max_health, health / max_health)
