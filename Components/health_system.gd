extends Node
class_name HealthSystem

@export var maxHealth: int
@export var sprite: Node2D

var currHealth: int
signal healthChanged

func damage_flash() -> void:
	if sprite:
		sprite.modulate = Color.RED
		await get_tree().create_timer(0.1).timeout
		sprite.modulate = Color.WHITE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currHealth = maxHealth
	healthChanged.emit()

func damage(damageAmount: int) -> void:
	currHealth -= damageAmount
	damage_flash()
	healthChanged.emit()

func heal(healAmount: int) -> void:
	currHealth += healAmount
	healthChanged.emit()
