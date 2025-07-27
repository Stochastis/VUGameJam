extends Node
class_name StateMachine

@export var initial_state: State

var states: Array[State]
var current_state: State

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
	
	#Don't run the ready/start script if this is a mini state machine. Let the parent state call it when it's entered.
	#Prevents a mini state machine from entering it's initial state prematurely.
	if get_parent() is State:
		return
	
	start()

func start() -> void:
	set_process(true)
	set_physics_process(true)
	
	for s: State in states:
		if not s.Transitioned.is_connected(child_transition):
			s.Transitioned.connect(child_transition)
	
	initial_state.enter()
	current_state = initial_state

func stop() -> void:
	set_process(false)
	set_physics_process(false)
	
	for s: State in states:
		if s.Transitioned.is_connected(child_transition):
			s.Transitioned.disconnect(child_transition)
	
	current_state.exit()
	current_state = null

func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func child_transition(state: State, newState: String):
	if state != current_state:
		return
	
	var next_state: State
	for s: State in states:
		var script: Script = s.get_script()
		while script:
			if script.get_global_name() ==  newState:
				next_state = s
				break
			script = script.get_base_script()
		if next_state:
			break
	
	if !next_state:
		push_warning("Unable to transition states. State not found: " + newState)
		return
	
	current_state.exit()
	current_state = next_state
	current_state.enter()
