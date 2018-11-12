extends Node

export (NodePath) var starting_area = "./City/TestArea"

var current_area
signal area_changed(new_area)

func _ready():
	current_area = $City.get_child(0)
	
	set_current_area(get_node(starting_area))
	

func set_current_area(new_area):
	
	if new_area == null:
		new_area = $Areas.get_child(0)
	current_area.visible = false
	new_area.visible = true
	
	for member in get_tree().get_nodes_in_group("Area Members"):
		member.visible = member.location == new_area
	
	current_area = new_area
	
	emit_signal("area_changed", new_area)