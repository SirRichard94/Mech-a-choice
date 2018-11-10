extends Node2D

onready var menu_panel = get_node("../GUI/VBoxContainer/Container/Menu Panel")

func _ready():
	var actions = $Actions.get_children()
	menu_panel.menu_items = actions
	menu_panel.call_deferred("refresh_items")