extends "res://Player/Actions/ActionItem.gd"

var MoveLocationScene = preload("res://Player/Actions/MoveLocation.tscn")



func _ready():
	description = "Skidaddle out of here"


func _do_action():
	var area = player.get_node("AreaComponent").get_area()
	var paths = area.get_paths()
	
	if paths.empty():
		description = "Nowhere to Go"
		return
	
	for child in get_children():
		child.queue_free()
	
	yield(get_tree(), "idle_frame")
	
	for path in paths:
		var move_to = MoveLocationScene.instance()
		move_to.target = path
		move_to.name = path.name
		
		add_child(move_to)
		
	yield(get_tree(), "idle_frame")
	
	gui.action_menu.title_text = "HERO ON THE MOVE"
	gui.action_menu.menu_items = get_children()
	