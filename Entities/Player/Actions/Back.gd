extends "res://Entities/Player/Actions/MenuAction.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	description = ""
	for child in get_parent().get_parent().get_children():
		description += "- " + child.name+"\n"

func _do_action():
	gui.action_menu.title_text = "HERO PONDERS: "+ get_parent().get_parent().name 
	gui.action_menu.menu_items = get_parent().get_parent().get_children()
	end_action()