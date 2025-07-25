extends NpcTargeting
class_name npc_targeting_zombie

@export var navAgent: NavigationAgent2D
@export var parent: CharacterBody2D
@export var moveSpeed: float = 20
@export var idleObservationArea: Area2D
@export var chaseObservationArea: Area2D
@export var attackArea: Area2D
@export var observer: Observer
@export var attack_cooldown: float

var nextPathPos: Vector2

func attack() -> void:
	if !targeter.targetNode:
		return
	attackArea = parent.Attack_Proximity
	if targeter.targetNode.has_node("HealthSystem") && attackArea.overlaps_body(targeter.targetNode):
		var targetHealthSystem: HealthSystem = targeter.targetNode.get_node("HealthSystem")
		targetHealthSystem.damage(10)

func physics_update(_delta: float) -> void:
	var toNextPath = (nextPathPos - parent.global_position).normalized()
	parent.velocity = toNextPath * moveSpeed
	parent.move_and_slide()

func _on_attack_timer_timeout() -> void:
	attack()
	$AttackTimer.start(attack_cooldown)

func _on_nav_timer_timeout() -> void:
	#Re-nav since the target can move
	navAgent.target_position = targeter.targetPosition
	nextPathPos = navAgent.get_next_path_position()

func enter() -> void:
	observer.observationArea = chaseObservationArea
	parent.target = targeter.targetNode
	if not $NavTimer.is_connected("timeout", _on_nav_timer_timeout):
		$NavTimer.connect("timeout", _on_nav_timer_timeout)

func exit() -> void:
	observer.observationArea = idleObservationArea
	if $NavTimer.is_connected("timeout", _on_nav_timer_timeout):
		$NavTimer.disconnect("timeout", _on_nav_timer_timeout)
