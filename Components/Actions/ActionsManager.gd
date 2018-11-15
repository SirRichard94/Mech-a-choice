extends Node

signal action_ended(action)

func _ready():
	connect("action_ended", self, "_on_action_ended")
	
	owner = get_parent()
	for child in get_children():
		child.owner = owner
		

func do_action(action):
	if typeof(action) == TYPE_STRING:
		action = get_node(action)
	
	if action != null:
		GlobalUtilities.pause_ATB()
		action._do_action()
	else:
		print(owner.name+": Action " + action + " not found")

func _on_action_ended(action):
	GlobalUtilities.resume_ATB()