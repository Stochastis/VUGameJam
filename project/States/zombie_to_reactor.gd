extends State
class_name ZombieToReactor

@onready var attackCollisionShape: CollisionShape2D = $"../../Attack_Proximity/CollisionShape2D"
@onready var idleObservingCollisionShape: CollisionShape2D = $"../../Focus_Area/CollisionShape2D"
@onready var chaseObservingCollisionShape: CollisionShape2D = $"../../Chase_Area/CollisionShape2D"
@onready var observer: Observer = $"../../Observer"
@onready var focus_area: Area2D = $"../../Focus_Area"

@export var navAgent: NavigationAgent2D
@export var parent: CharacterBody2D
@export var toReactorMoveSpeed: float = 15

func enter() -> void:
	$Timer.start()
	attackCollisionShape.disabled = true
	idleObservingCollisionShape.disabled = true
	chaseObservingCollisionShape.disabled = false
	$ChaseAfterLOSLostTimer.start()

func physics_update(_delta: float) -> void:
	var nextPathPos: Vector2 = navAgent.get_next_path_position()
	var toNextPath: Vector2 = (nextPathPos - parent.global_position).normalized()
	parent.velocity = toNextPath * toReactorMoveSpeed
	parent.move_and_slide()

func exit() -> void:
	$Timer.stop()
	attackCollisionShape.disabled = true
	idleObservingCollisionShape.disabled = false
	chaseObservingCollisionShape.disabled = true
	$ChaseAfterLOSLostTimer.stop()
	observer.observationArea = focus_area

func _on_timer_timeout() -> void:
	Transitioned.emit(self, "NpcIdle")
