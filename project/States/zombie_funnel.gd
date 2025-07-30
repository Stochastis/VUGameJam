extends State
class_name ZombieFunnel

@export var parent: Zombie
@export var navAgent: NavigationAgent2D
@export var zombieFunnelMoveSpeed: float = 20
@export var targeter: Targeter
@export var attackCollisionShape: CollisionShape2D
@export var idleObservingCollisionShape: CollisionShape2D
@export var chaseObservingCollisionShape: CollisionShape2D

func enter() -> void:
	if parent.name == "TestZom":
		print("Entered funnel state")
	
	attackCollisionShape.disabled = true
	idleObservingCollisionShape.disabled = true
	chaseObservingCollisionShape.disabled = true
	
	targeter.manualTargeting = true
	targeter.targetPosition = parent.funnelNode.global_position
	
	#The nav agent needs to wait for the navmesh to be rebaked after the wall is destroyed
	#Might consider moving this functionality to the wall itself and set the zom's position (or enter this state) whenever the navmesh baking is done
	await get_tree().create_timer(0.5).timeout
	navAgent.set_target_position(targeter.targetPosition)
	
	if not navAgent.target_reached.is_connected(_on_navigation_agent_2d_target_reached):
		navAgent.target_reached.connect(_on_navigation_agent_2d_target_reached)

func physics_update(_delta: float) -> void:
	var nextPathPos: Vector2 = navAgent.get_next_path_position()
	var toNextPath: Vector2 = (nextPathPos - parent.global_position).normalized()
	parent.velocity = toNextPath * zombieFunnelMoveSpeed
	parent.move_and_slide()

func _on_navigation_agent_2d_target_reached() -> void:
	Transitioned.emit(self, "NpcIdle")

func exit() -> void:
	if parent.name == "TestZom":
		print("Exiting funnel state")
	
	attackCollisionShape.disabled = true
	idleObservingCollisionShape.disabled = false
	chaseObservingCollisionShape.disabled = true
	
	targeter.manualTargeting = false
	if navAgent.target_reached.is_connected(_on_navigation_agent_2d_target_reached):
		navAgent.target_reached.disconnect(_on_navigation_agent_2d_target_reached)
