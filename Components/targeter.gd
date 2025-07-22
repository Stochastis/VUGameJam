extends Node2D
class_name Targeter

@export var observer: Observer
@export var trackedEntityGroups: Array[String]
@export var trackedEntityNames: Array[String]
@export var displayDebugGraphics: bool = true

const MAXFLOAT: float = 10000000000000000

var targetingEntity: bool = false
var targetPosition: Vector2

#TODO: Change this (using states) so that the soldier isn't just spinning around the last target forever
func _process(_delta: float) -> void:
	#Filter out not-targeting entities
	var possibleTargets: Array[Node2D]
	var observedEntities: Array[Node2D] = observer.observedEntities
	for group in trackedEntityGroups:
		possibleTargets.append_array(observedEntities.filter(func(node): return node.is_in_group(group) and not possibleTargets.has(node)))
	for trackedEntityName in trackedEntityNames:
		possibleTargets.append_array(observedEntities.filter(func(node): return node.name == trackedEntityName and not possibleTargets.has(node)))
		
	if possibleTargets.size() > 0:
		targetingEntity = true
		targetPosition = closestNode(possibleTargets).position
	else:
		targetingEntity = false
		
	#Debug Graphics
	queue_redraw()

func closestNode(nodes: Array[Node2D]) -> Node2D:
	var currClosestNode: Node2D = null
	var distanceToClosest: float = MAXFLOAT
	
	for node in nodes:
		var distanceToNode: float = position.distance_to(node.position)
		if distanceToNode < distanceToClosest:
			currClosestNode = node
			distanceToClosest = distanceToNode
	
	return currClosestNode
	
func _draw() -> void:
	if displayDebugGraphics:
		draw_line(position, to_local(targetPosition), Color.BLUE, 2)
		draw_circle(to_local(targetPosition), 20, Color.DARK_ORANGE, false)
