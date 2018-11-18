extends "res://Components/fsm/fsm_state.gd"

func on_atb_turn():
	if not owner.get_area().get_player():
		if owner.get_area().is_dead():
			owner.get_node("Actions").do_action("Move Random")
		else:
			owner.get_node("Actions").do_action("Hit Ground")
	else:
		if (randf() < 0.2):
			owner.get_node("Actions").do_action("Move Random")
		elif (randf() < 0.4):
			owner.get_node("Actions").do_action("Hit Ground")
		else:
			owner.get_node("Actions").do_action("Punch")