extends CharacterBody2D

const MAXFLOAT: float = 10000000000000000
var ROTATIONSPEED: float = 8
var zombiePosition: Vector2

var endPoint: Vector2 = Vector2(0, 0)
var startPoint: Vector2 = Vector2(0, 0)

func _draw() -> void:
	draw_line(startPoint, endPoint, Color.REBECCA_PURPLE, 2)

func _ready() -> void:
	zombiePosition = position + Vector2.from_angle(rotation)

func _process(delta: float) -> void:
	var overlappingBodies: Array[Node2D] = $ObservationArea.get_overlapping_bodies()
	# TODO: Change this method after merging in zombie changes so that it detects zombies instead of the enineer
	var zombiesInRange: Array[Node2D] = overlappingBodies.filter(func(node): return node.name == "Engineer")
	var observedZombies: Array[Node2D] = zombiesInRange.filter(func(node): return has_line_of_sight(node))
	
	if observedZombies.size() > 0:
		zombiePosition = closestNode(observedZombies).position
		$AnimatedSprite2D.set_frame_and_progress(1, 0)
	else:
		$AnimatedSprite2D.set_frame_and_progress(0, 0)
	
	var to_zombie = (zombiePosition - position).normalized()
	var desired_angle = to_zombie.angle()
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
	endPoint = to_local(zombiePosition)
	var query = PhysicsRayQueryParameters2D.create(global_position, target.global_position, 2, [self, target])
	var collision := get_world_2d().direct_space_state.intersect_ray(query)
	
	return collision.size() == 0
