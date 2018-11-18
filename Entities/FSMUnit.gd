extends "res://Entities/Unit.gd"

export (String) var initial_state = null

func _ready():
	var state = initial_state if initial_state != null else $FSM.get_child(0).name
	$FSM.switch_state(state)

func _process(delta):
	$FSM.update(delta)
		
func _fixed_process(delta):
	$FSM.fixed_update(delta)
	
func _input(event):
	$FSM.handle_input(event)
