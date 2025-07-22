extends Node2D
class_name Observer

@export var lineOfSight: LineOfSight
@export var observationArea: Area2D

const WALLMASK: int = 2

var observedEntities: Array[Node2D]

func _process(_delta: float) -> void:
	if observationArea and lineOfSight:
		var bodiesInArea: Array[Node2D] = observationArea.get_overlapping_bodies()
		observedEntities = bodiesInArea.filter(func(node): return lineOfSight.has_line_of_sight(node, WALLMASK))
		if lineOfSight.parent.name == "Zombie":
			print(observationArea.name)
