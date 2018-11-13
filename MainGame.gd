extends Node

export (String) var starting_area = "Park"

var current_area
signal area_changed(new_area)

func _ready():
	current_area = $City.get_child(0)
	
	set_current_area(starting_area)
	

func set_current_area(area_name):
	var new_area = $City.get_node(area_name)
	if new_area == null:
		return false
	current_area.visible = false
	new_area.visible = true
	
	for area_comp in get_tree().get_nodes_in_group("Area Components"):
		area_comp.owner.visible = area_comp.get_area() == new_area
	
	current_area = new_area
	
	emit_signal("area_changed", new_area)