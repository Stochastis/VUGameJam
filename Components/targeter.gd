extends Node2D
class_name Targeter

@export var parent: CharacterBody2D
@export var observer: Observer
@export var trackedEntityGroups: Array[String]
@export var trackedEntityNames: Array[String]
@export var displayDebugGraphics: bool = true
@export var ROTATIONSPEED: float = 8

const MAXFLOAT: float = 10000000000000000

var targetingEntity: bool = false
var targetPosition: Vector2
var targetNode: Node2D

#Don't need these signals right now, but might need them in the future.
#signal NewTargetAcquired
#signal TargetsLost

func _ready() -> void:
	resetTarget()

func resetTarget() -> void:
	targetingEntity = false
	targetNode = null
	targetPosition = global_position + (Vector2.from_angle(global_rotation) * 32)

func _process(delta: float) -> void:
	#Filter out not-targeting entities
	var possibleTargets: Array[Node2D]
	var observedEntities: Array[Node2D] = observer.observedEntities
	for group in trackedEntityGroups:
		possibleTargets.append_array(observedEntities.filter(func(node): return is_instance_valid(node) and node.is_in_group(group) and not possibleTargets.has(node)))
	for trackedEntityName in trackedEntityNames:
		possibleTargets.append_array(observedEntities.filter(func(node): return is_instance_valid(node) and node.name == trackedEntityName and not possibleTargets.has(node)))
	
	if possibleTargets.size() > 0:
		if not targetingEntity:
			targetingEntity = true
			#NewTargetAcquired.emit()
		if not is_instance_valid(targetNode) or not possibleTargets.has(targetNode):
			targetNode = closestNode(possibleTargets)
		targetPosition = targetNode.global_position
	else:
		if targetingEntity:
			targetingEntity = false
			targetNode = null
			#TargetsLost.emit()
	
	#Face target
	var to_target = (targetPosition - parent.position).normalized()
	var desired_angle = to_target.angle()
	parent.rotation = lerp_angle(parent.rotation, desired_angle, ROTATIONSPEED * delta)
	
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
		draw_circle(to_local(targetPosition), 20, Color.YELLOW_GREEN if parent.is_in_group("Good Guys") else Color.FIREBRICK, false, 3)
