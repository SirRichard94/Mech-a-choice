extends Node

# thanks to karoffel for this code

export var initial_state = ""

var state = null

var state_key = ""
var next_state_key = ""

func _ready():
	owner = get_parent()
	var timer = owner.get_node("ATBTimer")
	timer.connect("timeout", self, "on_atb_turn" )

func on_atb_turn():
	if state:
		state.on_atb_turn()
		
	_maybe_perform_transition()

func fixed_update(delta):
	if state:
		state.fixed_update(delta)
		
	_maybe_perform_transition()

func update(delta):
	if state:
		state.update(delta)
	
	_maybe_perform_transition()

func handle_input(event):
	if state:
		state.handle_input(event)
	
	_maybe_perform_transition()

func switch_state(new_state):
	next_state_key = new_state
	
func switch_state_immediately(new_state):
	switch_state(new_state)
	_maybe_perform_transition()

func _maybe_perform_transition():
	if next_state_key != "":
		if state:
			state.on_finalize()
		
		state_key = next_state_key
		next_state_key = ""
		
		state = get_node(state_key)
		if state:
			state.on_init()