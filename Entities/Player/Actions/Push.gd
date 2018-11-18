extends "res://Components/Actions/ActionItem.gd"

export var sequential = false

func _do_action():
	var paths = owner.get_area().get_paths()
	var target_area = paths[randi()%paths.size()].name
	
	for child in get_children():
		child.target_area = target_area
		child.ends_action = false
		child.call_deferred("_do_action")
		
		if sequential:
			yield(child, "action_ended")
	
	end_action()