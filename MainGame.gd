extends Node

export (NodePath) var starting_area = "./City/TestArea"

var current_area
signal area_changed(new_area)

func _ready():
	current_area = get_node(starting_area)
	if current_area == null:
		current_area = $Areas.get_child(0)
	
	$Player.location = current_area

func set_current_area(new_area):
	assert new_area.get_parent() == $City
	
	current_area.visible = false
	new_area.visible = true
	
	current_area = new_area
	emit_signal("area_changed", new_area)