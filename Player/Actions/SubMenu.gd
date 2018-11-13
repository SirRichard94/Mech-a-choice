extends "res://Player/Actions/ActionItem.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	description = ""
	for child in get_children():
		description += "- " + child.name + "\n"

func _do_action():
	gui.action_menu.title_text = name + " Actions"
	gui.action_menu.menu_items = get_children()

func is_disabled():
	return player.get_node("AreaComponent").get_area().enemy_count() == 0