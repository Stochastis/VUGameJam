extends NpcTargeting
class_name npc_targeting_zombie


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
	attackArea = parent.get_node("Attack_Proximity")
	if targeter.targetNode.has_node("HealthSystem") && attackArea.overlaps_body(targeter.targetNode):
		var targetHealthSystem: HealthSystem = targeter.targetNode.get_node("HealthSystem")
		targetHealthSystem.damage(10)
		var sprite : Sprite2D = parent.get_node("Pivot_Point/Sprite")
		sprite.modulate = Color.DARK_GRAY
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color.WHITE
		
func physics_update(_delta: float) -> void:
	var nextPathPos: Vector2 = navAgent.get_next_path_position()
	var toNextPath = (nextPathPos - parent.global_position).normalized()
	parent.velocity = toNextPath * npcTargetingZombieMoveSpeed
	parent.move_and_slide()

func _on_attack_timer_timeout() -> void:
	attack()
	$AttackTimer.start(attack_cooldown)

func reNav() -> void:
	#Re-nav once per second since the target can move
	navAgent.target_position = targeter.targetPosition
	nextPathPos = navAgent.get_next_path_position()
	$AttackTimer.start(attack_cooldown)

func enter() -> void:
	reNav()
	$NavTimer.start()
	observer.observationArea = chaseObservationArea

func exit() -> void:
	$NavTimer.stop()
