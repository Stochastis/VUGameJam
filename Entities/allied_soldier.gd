extends CharacterBody2D

const MAXFLOAT: float = 10000000000000000
var ROTATIONSPEED: float = 8
var zombiePosition: Vector2

func _ready() -> void:
	zombiePosition = position

func _process(delta: float) -> void:
	var overlappingBodies: Array[Node2D] = $ObservationArea.get_overlapping_bodies()
	# TODO: Change this method after merging in zombie changes so that it detects zombies instead of the enineer
	var zombies: Array[Node2D] = overlappingBodies.filter(func(node): return node.name == "Engineer")
	if zombies.size() > 0:
		zombiePosition = closestNode(zombies).position
	var to_zombie = (zombiePosition - position).normalized()
	var desired_angle = to_zombie.angle()
	rotation = lerp_angle(rotation, desired_angle, ROTATIONSPEED * delta)
	print(zombiePosition)

func closestNode(nodes: Array[Node2D]) -> Node2D:
	var currClosestNode: Node2D = null
	var distanceToClosest: float = MAXFLOAT
	
	for node in nodes:
		var distanceToNode: float = self.position.distance_to(node.position)
		if distanceToNode < distanceToClosest:
			currClosestNode = node
			distanceToClosest = distanceToNode
	
	return currClosestNode
