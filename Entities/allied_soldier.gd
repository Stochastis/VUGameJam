extends CharacterBody2D

@export var move_speed: float = 100
@export var observer: Observer
@export var targeter: Targeter
@export var ROTATIONSPEED: float = 8
@export var debugLines: bool = true

const MAXFLOAT: float = 10000000000000000

var observingEntity: bool = false

# Line of sight debug
var endPoint: Vector2 = Vector2(0, 0)
var startPoint: Vector2 = Vector2(0, 0)

func _ready() -> void:
	#TODO: Change this (using states) so that the soldier isn't just spinning around the initial target forever until a zombie happens to come within his LineOfSight
	targeter.targetPosition = position + Vector2.from_angle(rotation)

func _process(delta: float) -> void:
	#Awareness of Zombies
	var trackedObservedEntities: Array[Node2D] = observer.observedEntities
	
	if trackedObservedEntities.size() > 0:
		observingEntity = true
		targeter.targetPosition = closestNode(trackedObservedEntities).position
	else:
		observingEntity = false
	
	var to_target = (targeter.targetPosition - position).normalized()
	var desired_angle = to_target.angle()
	rotation = lerp_angle(rotation, desired_angle, ROTATIONSPEED * delta)
	
	if observingEntity:
		$AnimatedSprite2D.set_frame_and_progress(1, 0)
	else:
		$AnimatedSprite2D.set_frame_and_progress(0, 0)
	
	#Debug Lines
	startPoint = to_local(global_position)
	endPoint = to_local(targeter.targetPosition)
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
	if debugLines:
		draw_line(startPoint, endPoint, Color.BLUE, 2)
