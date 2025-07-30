extends StaticBody2D

@onready var reactor_animation: AnimatedSprite2D = $ReactorAnimation
@onready var emission_animation: AnimatedSprite2D = $EmissionAnimation
@onready var health_system: HealthSystem = $HealthSystem

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reactor_animation.play()
	emission_animation.play()

func repair(repairAmount: int) -> void:
	health_system.heal(repairAmount)
