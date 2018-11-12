extends Node2D

export (Array, String) var conected_locations = []

func _ready():
	pass

func enemies_in_area():
	var counter = 0
	for enemy in get_tree().current_scene.get_node("Enemies").get_children():
		if enemy.location == self: 
			counter+=1
	return counter