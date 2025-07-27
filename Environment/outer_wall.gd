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

func _on_zom_funnel_timer_timeout() -> void:
	funnelZoms()

func funnelZoms() -> void:
	var overlappingBodies: Array[Node2D] = $DestroyedFunnelArea.get_overlapping_bodies()
	for body in overlappingBodies:
		if not body.is_in_group("Zombies") or not body is Zombie:
			continue
		var zom: Zombie = body
		if zom.stateMachine.current_state.get_script().get_global_name() != "ZombieFunnel":
			funnelZom(zom)
	$ZomFunnelTimer.start()

func funnelZom(zom: Zombie) -> void:
	var currState: State = zom.stateMachine.current_state
	zom.funnelNode = $Inside
	currState.Transitioned.emit(currState, "ZombieFunnel")
