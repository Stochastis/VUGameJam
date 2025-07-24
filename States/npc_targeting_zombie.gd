extends NpcTargeting
class_name npc_targeting_zombie

@export var navAgent: NavigationAgent2D
@export var parent: CharacterBody2D
@export var moveSpeed: float = 20
@export var idleObservationArea: Area2D
@export var chaseObservationArea: Area2D
@export var observer: Observer

func targetingBehavior() -> void:
	var nextPathPos: Vector2 = navAgent.get_next_path_position()
	var toNextPath = (nextPathPos - parent.global_position).normalized()
	
	parent.velocity = toNextPath * moveSpeed
	parent.move_and_slide()

func _on_nav_timer_timeout() -> void:
	if targeter.targetingEntity:
		navAgent.target_position = targeter.targetPosition

func enter() -> void:
	observer.observationArea = chaseObservationArea
	if not $NavTimer.is_connected("timeout", _on_nav_timer_timeout):
		$NavTimer.connect("timeout", _on_nav_timer_timeout)

func exit() -> void:
	observer.observationArea = idleObservationArea
	if $NavTimer.is_connected("timeout", _on_nav_timer_timeout):
		$NavTimer.disconnect("timeout", _on_nav_timer_timeout)
