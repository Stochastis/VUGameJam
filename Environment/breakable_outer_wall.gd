extends Node2D

var direction: breakableOuterWallDirections

enum breakableOuterWallDirections {
	NorthToSouth,
	EastToWest,
	SouthToNorth,
	WestToEast
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match direction:
		breakableOuterWallDirections.NorthToSouth:
			$AnimatedSprite2D.set_frame_and_progress(0, 0)
		breakableOuterWallDirections.EastToWest:
			$AnimatedSprite2D.set_frame_and_progress(1, 0)
		breakableOuterWallDirections.SouthToNorth:
			$AnimatedSprite2D.set_frame_and_progress(2, 0)
		breakableOuterWallDirections.WestToEast:
			$AnimatedSprite2D.set_frame_and_progress(3, 0)
		_:
			push_error("Unknown breakableOuterWall direction")
