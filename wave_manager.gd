extends Node

@export var zombie: PackedScene
@export var enabled: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enabled:
		_on_timer_timeout()

func _on_timer_timeout() -> void:
	spawn_zombie()
	print("Spawned zombie")
	#restart timer
	$Timer.start()

func spawn_zombie() -> void:
	var zombieInstance = zombie.instantiate()
	var spawnPoints = $SpawnPoints.get_children()
	var spawnPoint: Vector2 = spawnPoints.pick_random().global_position
	zombieInstance.global_position = spawnPoint
	add_child(zombieInstance)
