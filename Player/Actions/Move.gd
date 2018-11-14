extends "res://Components/ActionItem.gd"

var MoveToAction = preload("res://Player/Actions/MoveToLocation.tscn")
var BackAction = preload("res://Player/Actions/Back.tscn")


func _ready():
	description = "Skidaddle out of here"

func get_paths():
	var area = player.get_node("AreaComponent").get_area()
	return area.get_paths()

func _do_action():
	var paths = get_paths()
	
	if paths.empty():
		description = "Nowhere to Go"
		return
	
	for child in get_children():
		child.queue_free()
	
	yield(get_tree(), "idle_frame")
	
	add_child(BackAction.instance())
	for path in paths:
		var move_to = MoveToAction.instance()
		move_to.target = path
		move_to.name = path.name
		
		add_child(move_to)
		
	yield(get_tree(), "idle_frame")
	
	gui.action_menu.title_text = "HERO ON THE MOVE"
	gui.action_menu.menu_items = get_children()

func is_disabled():
	return get_paths().empty()