extends Node2D
class_name Observer

@export var trackedEntityGroups: Array[String]
@export var trackedEntityNames: Array[String]
@export var lineOfSight: LineOfSight
@export var observationArea: Area2D

const WALLMASK: int = 2

var observedEntities: Array[Node2D]

func _process(_delta: float) -> void:
	var bodiesInArea: Array[Node2D] = observationArea.get_overlapping_bodies()
	var relevantBodiesInArea: Array[Node2D]
	for group in trackedEntityGroups:
		relevantBodiesInArea.append_array(bodiesInArea.filter(func(node): return node.is_in_group(group) and not relevantBodiesInArea.has(node)))
	for name in trackedEntityNames:
		relevantBodiesInArea.append_array(bodiesInArea.filter(func(node): return node.name == name and not relevantBodiesInArea.has(node)))
	
	observedEntities = relevantBodiesInArea.filter(func(node): return lineOfSight.has_line_of_sight(node, WALLMASK))
