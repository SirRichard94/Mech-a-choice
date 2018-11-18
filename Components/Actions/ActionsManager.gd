extends Node

signal action_ended(action)

func _ready():
	owner = get_parent()		

func do_action(action, stop_atb = true):
	if typeof(action) == TYPE_STRING:
		action = get_node(action)
	
	if action != null:
		if stop_atb:
			GlobalUtilities.pause_ATB()
		action.start_action()
		yield(self, "action_ended")
		if stop_atb:
			GlobalUtilities.resume_ATB()
	else:
		print(owner.name+": Action  not found")