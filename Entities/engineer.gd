extends CharacterBody2D

@export var move_speed: float = 150
@export var max_health: float = 100
@export var is_enemy: bool = false

@onready var current_health: float = max_health
@onready var health_bar = $HealthBar

func _ready():
	health_bar.init_health(max_health)

func _take_damage(amount: float) -> void:
	current_health -= amount
	
	health_bar.toggle_visible()
	health_bar.health = current_health
	
	if current_health <= 0:
		queue_free()

func _physics_process(_delta):
	var input_direction =  Input.get_vector("left", "right", "up", "down")
	
	velocity = input_direction * move_speed
	
	move_and_slide()
	
	get_node("pivotPoint").look_at(get_global_mouse_position())
