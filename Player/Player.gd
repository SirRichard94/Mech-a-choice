extends Node2D

onready var menu_panel = get_node("../GUI/VBoxContainer/Container/Menu Panel")

func _ready():
	var actions = $Actions.get_children()
	menu_panel.menu_items = actions
	
	yield(get_tree(),"idle_frame")
	menu_panel.refresh_items()
	menu_panel.appear()