extends "res://Components/Actions/ActionItem.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _do_action():
	print ( "HOOOOOOO " )
	owner.get_node("StatBlock").add_to_current("HP", 10)