extends Node

@export var zombie: PackedScene
@export var enabled: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enabled:
		_on_timer_timeout()

func _on_timer_timeout() -> void:
	spawn_zombie()
	$Timer.start()

func spawn_zombie() -> void:
	var spawnAreas = $SpawnAreas.get_children()
	var selectedSpawnArea: Area2D = spawnAreas.pick_random()
	var overlappingBodies: Array[Node2D] = selectedSpawnArea.get_overlapping_bodies()
	var enemies: Array[Node2D] = overlappingBodies.filter(func(body): return body.is_in_group("Enemies"))
	if enemies.is_empty():
		var spawnPoint: Vector2 = selectedSpawnArea.global_position
		var zombieInstance = zombie.instantiate()
		zombieInstance.global_position = spawnPoint
		add_child(zombieInstance)
		print("Spawned zombie")
