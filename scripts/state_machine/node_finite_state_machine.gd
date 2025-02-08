class_name NodeFiniteStateMachine
extends Node

@export var initial_node_state : NodeState

var node_states : Dictionary  = {}
var current_node_state : NodeState
var current_node_state_name : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	register_states(self)  # Register all states, including nested ones
	
	if initial_node_state:
		initial_node_state.enter()
		current_node_state = initial_node_state
		current_node_state_name = current_node_state.name.to_lower()
		print("On Ready - Initial state:", current_node_state.name)

# Recursive function to register all nested states
func register_states(node):
	for child in node.get_children():
		if child is NodeState:
			node_states[child.name.to_lower()] = child
			child.transition.connect(transition_to)
			# print("Registered state:", child.name)
		
		# If the child has children (like Attack1 under Attack), keep scanning
		if child.get_child_count() > 0:
			register_states(child)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	if current_node_state:
		current_node_state.on_process(delta)

func _physics_process(delta: float):
	if current_node_state:
		current_node_state.on_physics_process(delta)

	# Checks which state is active
	# print("Current State: ", current_node_state.name.to_lower())

func transition_to(node_state_name : String):
	if node_state_name == current_node_state.name.to_lower():
		return  # Prevent transitioning into the same state
	
	var new_node_state = node_states.get(node_state_name.to_lower())
	
	if !new_node_state:
		return
	
	if current_node_state:
		print("1 - Exiting state:", current_node_state.name)
		current_node_state.exit()
	
	print("2 - Transitioning to state:", new_node_state.name)
	new_node_state.enter()
	current_node_state = new_node_state
	current_node_state_name = current_node_state.name.to_lower()
	print("3 - Now in state:", current_node_state.name)
