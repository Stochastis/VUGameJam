extends NpcTargeting
class_name NpcTargetingZombie

@export var parent: CharacterBody2D
@export var npcTargetingZombieMoveSpeed: float = 20
@export var chaseObservationArea: Area2D
@export var observer: Observer
@export var attack_cooldown: float
@export var attackArea: Area2D
@export var idleObservationArea: Area2D
@export var attackCollisionShape: CollisionShape2D
@export var idleObservingCollisionShape: CollisionShape2D
@export var chaseObservingCollisionShape: CollisionShape2D

func attack() -> void:
	if !targeter.targetNode:
		return
	if targeter.targetNode.has_node("HealthSystem") && attackArea.overlaps_body(targeter.targetNode):
		var targetHealthSystem: HealthSystem = targeter.targetNode.get_node("HealthSystem")
		targetHealthSystem.damage(10)
	elif not targeter.targetNode.has_node("HealthSystem"):
		print_debug(parent.name + "'s attack unsuccessful. Target node (" + targeter.targetNode.name + ") does not have a HealthSystem component.")
		
func physics_update(_delta: float) -> void:
	var toTarget = (targeter.targetPosition - parent.global_position).normalized()
	parent.velocity = toTarget * npcTargetingZombieMoveSpeed
	parent.move_and_slide()

func _on_attack_timer_timeout() -> void:
	attack()
	$AttackTimer.start(attack_cooldown)

func enter() -> void:
	if parent.name == "TestZom":
		print("TestZom Entering Targeting state")
	
	attackCollisionShape.disabled = false
	idleObservingCollisionShape.disabled = true
	chaseObservingCollisionShape.disabled = false
	$AttackTimer.start(attack_cooldown)
	observer.observationArea = chaseObservationArea

func exit() -> void:
	if parent.name == "TestZom":
		print("TestZom Exiting Targeting state")
	
	attackCollisionShape.disabled = true
	idleObservingCollisionShape.disabled = false
	chaseObservingCollisionShape.disabled = true
	$AttackTimer.stop()
	observer.observationArea = idleObservationArea
