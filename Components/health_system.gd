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

func damage(damageAmount: int) -> void:
	currHealth -= damageAmount
	damage_flash()
	healthChanged.emit()
	if currHealth <= 0 and not healthChanged.has_connections():
		print_debug(get_parent().name + "'s HealthSystem component went to 0 health, but no listeners connected to healthChanged signal.")

func heal(healAmount: int) -> void:
	currHealth += healAmount
	healthChanged.emit()
