extends Camera2D

@export var zoom_factor := 1.1
@export var min_zoom := 0.5
@export var max_zoom := 7.5

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if Input.is_action_just_pressed("camera_zoom_out"):
			adjust_zoom(1.0 / zoom_factor)  # Zoom in
		if Input.is_action_just_pressed("camera_zoom_in"):
			adjust_zoom(zoom_factor)  # Zoom out

func adjust_zoom(factor: float):
	var new_zoom = zoom * Vector2(factor, factor)
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	zoom = new_zoom
