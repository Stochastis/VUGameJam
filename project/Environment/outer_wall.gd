extends Node2D
class_name OuterWall

@onready var outerWallManager: OuterWallManager = get_node("/root/Main/OuterWallManager")

const ACCESSIBLENAVLAYER: int = 2

var destroyed: bool = false

func makeBreakable() -> void:
	$AnimatedSprite2D.set_frame_and_progress(1, 0)
	add_to_group("Breakable")

func _on_health_system_health_changed() -> void:
	#Destroyed
	if $HealthSystem.currHealth <= 0:
		$AnimatedSprite2D.set_frame_and_progress(2, 0)
		
		$CollisionShape2D.disabled = true
		$NavigationRegion2D.set_navigation_layer_value(ACCESSIBLENAVLAYER, true)
		
		funnelZoms()
		remove_from_group("Breakable")
		
		if outerWallManager.outerWalls.has(self):
			outerWallManager.outerWalls.erase(self)
	#Damaged
	elif $HealthSystem.currHealth < $HealthSystem.maxHealth:
		$AnimatedSprite2D.set_frame_and_progress(1, 0)
		
		$CollisionShape2D.disabled = false
		$NavigationRegion2D.set_navigation_layer_value(ACCESSIBLENAVLAYER, false)
		
		$ZomFunnelTimer.stop()
		add_to_group("Breakable")
		
		if outerWallManager.outerWalls.has(self):
			outerWallManager.outerWalls.erase(self)
	#Full Health
	else:
		$AnimatedSprite2D.set_frame_and_progress(0, 0)
		
		$CollisionShape2D.disabled = false
		$NavigationRegion2D.set_navigation_layer_value(ACCESSIBLENAVLAYER, false)
		
		$ZomFunnelTimer.stop()
		remove_from_group("Breakable")
		
		if not outerWallManager.outerWalls.has(self):
			outerWallManager.outerWalls.append(self)

func repair(repairAmount: int) -> void:
	$HealthSystem.heal(repairAmount)

func replace() -> void:
	$HealthSystem.fullHeal()

func _on_zom_funnel_timer_timeout() -> void:
	funnelZoms()

func funnelZoms() -> void:
	var overlappingBodies: Array[Node2D] = $DestroyedFunnelArea.get_overlapping_bodies()
	for body in overlappingBodies:
		if not body.is_in_group("Zombies") or not body is Zombie:
			continue
		var zom: Zombie = body
		if not zom.stateMachine.current_state is ZombieFunnel:
			funnelZom(zom)
	$ZomFunnelTimer.start()

func funnelZom(zom: Zombie) -> void:
	var currState: State = zom.stateMachine.current_state
	zom.funnelNode = $Inside
	currState.Transitioned.emit(currState, "ZombieFunnel")
