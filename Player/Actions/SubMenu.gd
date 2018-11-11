extends "res://Player/Actions/ActionItem.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	description = ""
	for child in get_children():
		description += child.name+"\n"

func _do_action():
	player.action_menu.title_text = name + " Actions"
	player.action_menu.menu_items = get_children()