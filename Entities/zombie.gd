extends CharacterBody2D

@export var move_speed: float = 20
@export var max_health: int = 100
@export var cooldown: = 1.0
@export var ROTATIONSPEED: float = 1
@export var targeter: Targeter

@onready var target = null
@onready var current_health: int = max_health
@onready var navAgent := $NavigationAgent2D as NavigationAgent2D

var can_attack = true

func is_zombie(entity):
	return entity.is_in_group("Zombies")

func _physics_process(_delta):
	#TODO: Move this to a state when ready
	if targeter.targetingEntity:
		var nextPathPos: Vector2 = navAgent.get_next_path_position()
		var toNextPath = (nextPathPos - global_position).normalized()
		
		velocity = toNextPath * move_speed
		move_and_slide()

#TODO: Change this to a state when ready
func _on_targeter_new_target_acquired() -> void:
	$Observer.observationArea = $Chase_Area

#TODO: Change this to a state when ready
func _on_targeter_targets_lost() -> void:
	$Observer.observationArea = $Focus_Area

func _on_nav_timer_timeout() -> void:
	if targeter.targetingEntity:
		navAgent.target_position = targeter.targetPosition

func _on_attack_proximity_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if body == target:
		if can_attack and body.has_node("HealthSystem"):
			body.get_node("HealthSystem").damage(10)
			can_attack = false;
		elif not body.has_node("HealthSystem"):
			printerr("body does not have HealthSystem component")
		get_tree().create_timer(cooldown).timeout.connect(func(): can_attack = true)
