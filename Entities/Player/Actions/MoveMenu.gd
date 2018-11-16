extends "res://Entities/Player/Actions/MenuAction.gd"

var MoveToAction = preload("res://Entities/Player/Actions/PlayerMoveToArea.tscn")
var BackAction = preload("res://Entities/Player/Actions/MenuBack.tscn")

func _do_action():
	var area = player.get_node("AreaComponent").get_area()
	var paths =  area.get_paths()

	if paths.empty():
		description = "Nowhere to Go"
		return
	
	for child in get_children():
		child.queue_free()
	
	yield(get_tree(), "idle_frame")
	
	add_child(BackAction.instance())
	
	
	for path in paths:
		var move_to = MoveToAction.instance()
		move_to.target_area = path.name
		move_to.name = path.name
		if (area.enemy_count() > 0 ):
			move_to.energy_cost = 1
		
		add_child(move_to)
		
	yield(get_tree(), "idle_frame")
	
	gui.action_menu.title_text = "HERO ON THE MOVE"
	gui.action_menu.menu_items = get_children()

func is_disabled():
	var area = player.get_node("AreaComponent").get_area()
	return area.get_paths().empty()