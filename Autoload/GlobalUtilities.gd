extends Node

var cam_container

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