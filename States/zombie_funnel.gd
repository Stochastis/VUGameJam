extends State
class_name ZombieFunnel

@export var parent: Zombie
@export var navAgent: NavigationAgent2D
@export var zombieFunnelMoveSpeed: float = 20
@export var targeter: Targeter

func enter() -> void:
	if parent.name == "TestZom":
		print("Entered funnel state")
		print(parent.funnelNode.global_position)
	
	targeter.manualTargeting = true
	targeter.targetPosition = parent.funnelNode.global_position
	navAgent.target_position = parent.funnelNode.global_position
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
	
	targeter.manualTargeting = false
	if navAgent.target_reached.is_connected(_on_navigation_agent_2d_target_reached):
		navAgent.target_reached.disconnect(_on_navigation_agent_2d_target_reached)
