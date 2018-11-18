extends Node

export (String) var starting_area = "Park"

var current_area
signal area_changed(new_area)

func _ready():
	current_area = get_tree().get_nodes_in_group("Areas")[0]
	set_current_area(starting_area)

var chasing = false

func set_current_area(area_name, chase_time = -1):
	var new_area = GlobalUtilities.get_area(area_name)
	if new_area == null:
		return false
	current_area.visible = false
	new_area.visible = true
	
	for area_comp in get_tree().get_nodes_in_group("Area Components"):
		area_comp.owner.visible = area_comp.get_area() == new_area
		
	var old_area = current_area
	current_area = new_area
	emit_signal("area_changed", new_area)
	if chase_time > 0 and not chasing:
		chasing = true
		yield(get_tree().create_timer(chase_time), "timeout")
		set_current_area(old_area.name)
		chasing = false