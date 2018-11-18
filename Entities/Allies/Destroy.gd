extends Node

onready var fsm = get_parent()
onready var fsm_owner = fsm.get_parent()

func on_atb_turn():
	if fsm_owner.get_area().get_enemies().empty():
		fsm_owner.switch_state_immediately("Search")
	else:
		print (fsm_owner.unit_name+"shooting")
		fsm_owner.get_node("Actions").do_action("Shoot")

func on_init():
	pass

func on_finalize():
	pass

func fixed_update(delta):
	pass

func update(delta):
	pass

func handle_input(event):
	pass