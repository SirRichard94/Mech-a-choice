extends "res://Components/Actions/ActionItem.gd"

export var sequential = false

func _do_action():
	for child in get_children():
		child.ends_action = false
		child.call_deferred("_do_action")
		
		if sequential:
			yield(child, "action_ended")
	
	end_action()