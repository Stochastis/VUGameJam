extends Node

@export var initial_state: State

var states: Dictionary = {}
var current_state: State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(child_transition)
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func child_transition(state, new_state_name):
	if state != current_state:
		return
	
	var next_state = states.get(new_state_name.to_lower())
	if !next_state:
		return
	
	print("Exiting " + current_state.name + ". Entering " + next_state.name)
	current_state.exit()
	current_state = next_state
	current_state.enter()
