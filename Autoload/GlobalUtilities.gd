extends Node

var cam_container

func broadcast_message(message, priority=3):
	var gui = get_tree().current_scene.get_node("GUI")
	gui.newscaster.announce(message, priority)

func pause_ATB():
	for timer in get_tree().get_nodes_in_group("ATB Timers"):
		timer.paused = true
func resume_ATB():
	for timer in get_tree().get_nodes_in_group("ATB Timers"):
		timer.paused = false

func screen_shake(amt):
	if cam_container != null:
		cam_container.add_shake(amt)

func get_area(name):
	var areas = get_tree().get_nodes_in_group("Areas")
	for area in areas:
		if area.name == name:
			return area
	return null

func get_current_area():
	return get_tree().current_scene.current_area

func get_route(area_a, area_b):
	if astar == null:
		setup_astar()
	
	var path = astar.get_id_path(area_id_dict[area_a.name], area_id_dict[area_b.name] )
	var a_path = []
	for id in path:
		a_path.append(id_area_dict[id])
	return a_path

var astar = null
var area_id_dict = {}
var id_area_dict = {}

func setup_astar():	
	if astar != null:
		return
	astar = CustomAstar.new()
	var areas = get_tree().get_nodes_in_group("Areas")
	for area in areas:
		var i = astar.get_available_point_id ( )
		astar.add_point(i,Vector3())
		area_id_dict[area.name] = i

		for path in area.get_paths():
			if area_id_dict.has(path.name):
				astar.connect_points(area_id_dict[area.name], area_id_dict[path.name], true)
			
	for key in area_id_dict.keys():
		var id = area_id_dict[key]
		id_area_dict[id] = key

class CustomAstar extends AStar:
	func _compute_cost(from, to):
		return 1

	func _estimate_cost(a, b):
		return 0