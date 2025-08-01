extends StaticBody2D
class_name Reactor

@onready var reactor_animation: AnimatedSprite2D = $ReactorAnimation
@onready var emission_animation: AnimatedSprite2D = $EmissionAnimation
@onready var health_system: HealthSystem = $HealthSystem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reactor_animation.play()
	emission_animation.play()

func repair(repairAmount: int) -> void:
	health_system.heal(repairAmount)

func _on_health_system_health_changed() -> void:
	if health_system.currHealth <= 0:
		get_tree().change_scene_to_file("res://game_over.tscn")
