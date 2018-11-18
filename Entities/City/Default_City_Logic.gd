extends "res://Components/fsm/fsm_state.gd" 

export var action = "DefaultAction"
export var value = 2
export var message = "buffed the player"

func on_atb_turn():
	fsm_owner.get_node("Actions").do_action(action)
	GlobalUtilities.broadcast_message("Live from "+fsm_owner.unit_name+": \n"+message, 2)

func on_init():
	if fsm_owner.get_node("Actions/"+action).get("temp_time"):
		fsm_owner.get_node("Actions/"+action).value = value
	if fsm_owner.get_node("Actions/"+action).get("temp_time"):
		fsm_owner.get_node("Actions/"+action).temp_time = 60.0/(fsm_owner.stats.get_current("Speed")+ fsm_owner.stats.get_current("HP"))
	
func on_finalize():
	pass

func fixed_update(delta):
	pass
	
func update(delta):
	var hp = fsm_owner.stats.get_current("HP")
	var max_hp = fsm_owner.stats.get_max("HP")
	if hp  < (max_hp/3.0):
		fsm.switch_state("Weakest")
	elif hp< (2.0*max_hp/3.0):
		fsm.switch_state("Weak")
	elif hp <=0:
		fsm.switch_state("Dead")
		GlobalUtilities.broadcast_message(fsm_owner.name+" was destroyed", 0)
		fsm_owner.modulate = Color(1,0,0)

func handle_input(event):
	pass