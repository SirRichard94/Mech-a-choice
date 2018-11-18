extends "res://Components/fsm/fsm_state.gd"

var route = []

func on_atb_turn():
	if owner.get_area().get_enemies().empty():
		var area = get_next_move_point()
		if area != null:
			fsm_owner.get_node("Actions/MoveForward").target_area = area
			fsm_owner.get_node("Actions").do_action("MoveForward")
	else:
		fsm.switch_state_immediately("Destroy")

func get_next_move_point():
	if route.empty() and not get_tree().get_nodes_in_group("Enemies").empty() :
		route = GlobalUtilities.get_route(owner.get_area(), get_tree().get_nodes_in_group("Enemies")[0].get_area())
	return route.pop_front()
	
func on_init():
	if route.empty() and not get_tree().get_nodes_in_group("Enemies").empty() :
		route = GlobalUtilities.get_route(owner.get_area(), get_tree().get_nodes_in_group("Enemies")[0].get_area())
	
func on_finalize():
	route = []

func fixed_update(delta):
	pass
	
func update(delta):
	pass

func handle_input(event):
	pass