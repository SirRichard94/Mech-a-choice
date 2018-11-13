extends Node

export (String) var starting_area

signal area_changed 

var area_node setget set_area_node

onready var main_scene = get_tree().current_scene
onready var city = main_scene.get_node("City")

func _ready():
	owner = get_parent()
	add_to_group("Area Components")
	set_area(starting_area)

func set_area(area_name):
	set_area_node( city.get_node(area_name) )
	
	
func set_area_node(area):
	assert area.get_parent() == city
	area_node = area
	owner.visible = area_node == main_scene.current_area
	emit_signal("area_changed")

func get_area():
	return area_node