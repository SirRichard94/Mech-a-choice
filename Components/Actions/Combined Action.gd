extends "res://Components/Actions/ActionItem.gd"

func _do_action():
	for child in get_children():
		child._do_action()
	end_action()