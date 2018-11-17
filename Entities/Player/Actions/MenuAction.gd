extends "res://Components/Actions/ActionItem.gd"

export var title = "HERO CHOOSES BRAVE ACTION !"

func _get_description():
	description = ""
	for child in get_children():
		description += "- " + child.name+"\n"
	return description

func _init():
	is_menu_action = true

func _ready():
	ends_action = false
	for child in get_children():
		child.owner = owner


func _do_action():
	var action_menu = gui.action_menu
	
	action_menu.title_text = self.title
	action_menu.menu_items = get_children()
	action_menu.active = true
	
	end_action()