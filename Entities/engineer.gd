extends CharacterBody2D

@export var move_speed: float = 150

func _physics_process(_delta):
	var input_direction =  Input.get_vector("left", "right", "up", "down")
	
	velocity = input_direction * move_speed
	
	move_and_slide()
	
	get_node("pivotPoint").look_at(get_global_mouse_position())
