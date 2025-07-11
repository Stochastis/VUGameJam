extends Node

@export var parent: Node2D

# Line of sight debug
var endPoint: Vector2 = Vector2(0, 0)
var startPoint: Vector2 = Vector2(0, 0)
@export var debugLines: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
