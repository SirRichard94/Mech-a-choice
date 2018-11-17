extends Node

signal action_ended(action)

func _ready():
	owner = get_parent()		

func do_action(action):
	if typeof(action) == TYPE_STRING:
		action = get_node(action)
	
	if action != null:
		GlobalUtilities.pause_ATB()
		action.start_action()
		yield(self, "action_ended")
		GlobalUtilities.resume_ATB()
	else:
		print(owner.name+": Action " + action + " not found")