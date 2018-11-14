extends "res://General/Unit.gd"

func get_paths():
	assert get_node("Paths") != null
	var list = []
	for path in $Paths.get_children():
		var location = get_parent().get_node(path.name) 
		if location != null:
			list.append(location)
	if list.empty():
		print("No Paths in "+name)
	return list

func enemy_count():
	return get_enemies().size()

func get_enemies():
	var enemies = []
	for area_comp in get_tree().get_nodes_in_group("Area Components"):
		if area_comp.owner.is_in_group("Enemies") and area_comp.get_area() == self:
			enemies.append(area_comp.owner)
	return enemies