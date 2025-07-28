extends Node

@export var zombie: PackedScene
@export var enabled: bool = true
@export var startingSpawnFrequency: float
@export var timeBetweenSpeedUps: float
@export var speedUpAmount: float
@export var centerNode: Node2D

var spawnWaitTime: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enabled:
		spawnWaitTime = startingSpawnFrequency
		_on_timer_timeout()
		$WaveTimer.start(timeBetweenSpeedUps)

func _on_timer_timeout() -> void:
	spawn_zombie()
	$SpawnTimer.start(spawnWaitTime)

func _on_wave_timer_timeout() -> void:
	spawnWaitTime = max(0.1, spawnWaitTime - speedUpAmount)

func spawn_zombie() -> void:
	var spawnAreas = $SpawnAreas.get_children()
	var selectedSpawnArea: Area2D = spawnAreas.pick_random()
	var overlappingBodies: Array[Node2D] = selectedSpawnArea.get_overlapping_bodies()
	var enemies: Array[Node2D] = overlappingBodies.filter(func(body): return body.is_in_group("Zombies"))
	if enemies.is_empty():
		var spawnPoint: Vector2 = selectedSpawnArea.global_position
		var zombieInstance: Zombie = zombie.instantiate()
		zombieInstance.global_position = spawnPoint
		add_child(zombieInstance)
		var targeter: Targeter = zombieInstance.get_node("Targeter")
		targeter.targetPosition = centerNode.global_position
		if zombieInstance.stateMachine.current_state is NpcIdle:
			var idleStateMachine: StateMachine = zombieInstance.stateMachine.current_state.get_node("StateMachine")
			var currState: State = idleStateMachine.current_state
			currState.Transitioned.emit(currState, "NpcIdleWalk")
		#print("Spawned zombie at " + str(zombieInstance.global_position))
