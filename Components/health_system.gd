extends Node
class_name HealthSystem

@export var maxHealth: int
var currHealth: int
signal healthChanged

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currHealth = maxHealth
	healthChanged.emit()

func damage(damageAmount: int) -> void:
	currHealth -= damageAmount
	healthChanged.emit()

func heal(healAmount: int) -> void:
	currHealth += healAmount
	healthChanged.emit()
