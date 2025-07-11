extends Node2D

@export var ROTATIONSPEED: float = 8
@export var parent: Node2D
@export var observationArea: Area2D
@export var trackedEntityName: String

const MAXFLOAT: float = 10000000000000000
var targetPosition: Vector2
var observingEntity: bool = true

# Line of sight debug
var endPoint: Vector2 = Vector2(0, 0)
var startPoint: Vector2 = Vector2(0, 0)
@export var debugLines: bool = true

func _draw() -> void:
	if debugLines:
		draw_line(startPoint, endPoint, Color.REBECCA_PURPLE, 2)

func _ready() -> void:
	targetPosition = parent.position + Vector2.from_angle(parent.rotation)

func _process(delta: float) -> void:
	var overlappingBodies: Array[Node2D] = observationArea.get_overlapping_bodies()
	var entitiesInRange: Array[Node2D] = overlappingBodies.filter(func(node): return node.name == trackedEntityName)
	var observedEntities: Array[Node2D] = entitiesInRange.filter(func(node): return has_line_of_sight(node))
	
	if observedEntities.size() > 0:
		observingEntity = true
		targetPosition = closestNode(observedEntities).position
	else:
		observingEntity = false
	
	var to_target = (targetPosition - position).normalized()
	var desired_angle = to_target.angle()
	rotation = lerp_angle(rotation, desired_angle, ROTATIONSPEED * delta)
	
	queue_redraw()

func closestNode(nodes: Array[Node2D]) -> Node2D:
	var currClosestNode: Node2D = null
	var distanceToClosest: float = MAXFLOAT
	
	for node in nodes:
		var distanceToNode: float = self.position.distance_to(node.position)
		if distanceToNode < distanceToClosest:
			currClosestNode = node
			distanceToClosest = distanceToNode
	
	return currClosestNode

func has_line_of_sight(target: Node2D) -> bool:
	startPoint = to_local(global_position)
	endPoint = to_local(targetPosition)
	var query = PhysicsRayQueryParameters2D.create(global_position, target.global_position, 2, [self, target])
	var collision := get_world_2d().direct_space_state.intersect_ray(query)
	
	return collision.size() == 0
