extends NpcTargeting
class_name NpcTargetingZombie

@export var navAgent: NavigationAgent2D
@export var parent: CharacterBody2D
@export var npcTargetingZombieMoveSpeed: float = 20
@export var chaseObservationArea: Area2D
@export var attackArea: Area2D
@export var observer: Observer
@export var attack_cooldown: float

var nextPathPos: Vector2

func attack() -> void:
	if !targeter.targetNode:
		return
	if targeter.targetNode.has_node("HealthSystem") && attackArea.overlaps_body(targeter.targetNode):
		print("health system acquired and overlapping for attack")
		var targetHealthSystem: HealthSystem = targeter.targetNode.get_node("HealthSystem")
		targetHealthSystem.damage(10)
		var sprite : Sprite2D = parent.get_node("Pivot_Point/Sprite")
		sprite.modulate = Color.DARK_GRAY
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color.WHITE

func physics_update(_delta: float) -> void:
	nextPathPos = navAgent.get_next_path_position()
	var toNextPath = (nextPathPos - parent.global_position).normalized()
	parent.velocity = toNextPath * npcTargetingZombieMoveSpeed
	parent.move_and_slide()

func _on_attack_timer_timeout() -> void:
	attack()
	$AttackTimer.start(attack_cooldown)

func reNav() -> void:
	#Re-nav once per second since the target can move
	navAgent.target_position = targeter.targetPosition

func enter() -> void:
	reNav()
	$NavTimer.start()
	$AttackTimer.start(attack_cooldown)
	observer.observationArea = chaseObservationArea

func exit() -> void:
	$NavTimer.stop()
	$AttackTimer.stop()
