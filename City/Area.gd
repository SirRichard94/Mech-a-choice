extends Node2D


func _ready():
	if get_node("ATBTimer"):
		$ATBTimer.connect("timeout", self, "_on_ATB_turn")

func _on_ATB_turn():
	pass

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
	for enemy in get_tree().current_scene.get_node("Enemies").get_children():
		if enemy.location == self: 
			enemies.append(enemy)
	return enemies