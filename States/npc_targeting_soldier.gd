extends NpcTargeting
class_name npc_targeting_soldier

@export var animSprite2D: AnimatedSprite2D
@export var shootRestTime: float

func shoot() -> void:
	if !targeter.targetNode:
		return
	if targeter.targetNode.has_node("HealthSystem"):
		var targetHealthSystem: HealthSystem = targeter.targetNode.get_node("HealthSystem")
		targetHealthSystem.damage(25)

func _on_shoot_timer_timeout() -> void:
	shoot()
	$ShootTimer.start(shootRestTime)

func enter() -> void:
	animSprite2D.set_frame_and_progress(1, 0)
	$ShootTimer.start(shootRestTime)

func exit() -> void:
	animSprite2D.set_frame_and_progress(0, 0)
