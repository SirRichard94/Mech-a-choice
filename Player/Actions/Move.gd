extends "res://Player/Actions/ActionItem.gd"

var MoveLocationScene = preload("res://Player/Actions/MoveLocation.tscn")



func _ready():
	description = "Skidaddle out of here"


func _do_action():
	for child in get_children():
		child.queue_free()
	
	yield(get_tree(), "idle_frame")
	
	var location = player.location
	if location.conected_locations == null:
		print ("no paths")
		return
	
	for path in location.conected_locations:
		var move_to = MoveLocationScene.instance()
		var target = location.get_parent().get_node(path)
		move_to.target = target
		move_to.name = target.name
		
		add_child(move_to)
		
	yield(get_tree(), "idle_frame")
	
	gui.action_menu.title_text = "HERO ON THE MOVE"
	gui.action_menu.menu_items = get_children()
	