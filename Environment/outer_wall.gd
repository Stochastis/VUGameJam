extends Node2D
class_name OuterWall

var destroyed: bool = false

func makeBreakable() -> void:
	$AnimatedSprite2D.set_frame_and_progress(1, 0)
	add_to_group("Breakable")

func _on_health_system_health_changed() -> void:
	if $HealthSystem.currHealth <= 0:
		$AnimatedSprite2D.set_frame_and_progress(2, 0)
		$CollisionShape2D.disabled = true
		$NavigationRegion2D.enabled = true
		$NavigationRegion2D.bake_navigation_polygon()
		funnelZoms()

func _on_destroyed_funnel_area_body_entered(body: Node2D) -> void:
	if destroyed and body is Zombie:
		funnelZom(body)

func funnelZoms() -> void:
	var overlappingBodies: Array[Node2D] = $DestroyedFunnelArea.get_overlapping_bodies()
	for body in overlappingBodies:
		if not body.is_in_group("Zombies"):
			continue
		funnelZom(body)

func funnelZom(zom: Zombie) -> void:
	var currState: State = zom.stateMachine.current_state
	zom.funnelNode = $Inside
	currState.Transitioned.emit(currState, "ZombieFunnel")
