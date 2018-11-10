extends Node2D

onready var menu_panel = get_node("../GUI/Menu Panel")

func _ready():
	var actions = $Actions.get_children()
	menu_panel.menu_items = actions
	menu_panel.refresh_items()

