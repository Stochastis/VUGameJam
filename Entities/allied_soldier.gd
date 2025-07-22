extends CharacterBody2D

@export var move_speed: float = 100
@export var lineOfSight: LineOfSight
@export var trackedEntityName: String
@export var ROTATIONSPEED: float = 8
@export var debugLines: bool = true

const MAXFLOAT: float = 10000000000000000

var observingEntity: bool = false
var targetPosition: Vector2

# Line of sight debug
var endPoint: Vector2 = Vector2(0, 0)
var startPoint: Vector2 = Vector2(0, 0)

func _ready() -> void:
	targetPosition = position + Vector2.from_angle(rotation)

func _process(delta: float) -> void:
	#Awareness of Zombies
	var overlappingBodies: Array[Node2D] = $ObservationArea.get_overlapping_bodies()
	var trackedEntitiesInRange: Array[Node2D] = overlappingBodies.filter(func(node): return node.name == trackedEntityName)
	var trackedObservedEntities: Array[Node2D] = trackedEntitiesInRange.filter(func(node): return lineOfSight.has_line_of_sight(node, 2))
	
	if trackedObservedEntities.size() > 0:
		observingEntity = true
		targetPosition = closestNode(trackedObservedEntities).position
	else:
		observingEntity = false
	
	var to_target = (targetPosition - position).normalized()
	var desired_angle = to_target.angle()
	rotation = lerp_angle(rotation, desired_angle, ROTATIONSPEED * delta)
	
	
	if observingEntity:
		$AnimatedSprite2D.set_frame_and_progress(1, 0)
	else:
		$AnimatedSprite2D.set_frame_and_progress(0, 0)
	
	#Debug Lines
	startPoint = to_local(global_position)
	endPoint = to_local(targetPosition)
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
