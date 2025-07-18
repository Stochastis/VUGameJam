extends Node

@export var maxHealth: int
var currHealth: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currHealth = maxHealth

func damage(damageAmount: int) -> void:
	currHealth -= damageAmount
	
func heal(healAmount: int) -> void:
	currHealth += healAmount
