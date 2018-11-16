extends "res://Components/Actions/ActionItem.gd"

export (PackedScene) var unit_scene
export var amount = 1
export (String) var spawn_area = null

export (String) var spawn_animation = null
export (String) var end_animation = null

func _do_action():
	var current_spawn_area
	if spawn_area == null:
		current_spawn_area = owner.area_component.get_area().name
	else:
		current_spawn_area = spawn_area
	
	var unit = unit_scene.instance(false)
	var scene = get_tree().current_scene
	
	var groups = unit.get_groups()
	if groups.has("Allies"):
		scene.get_node("Allies").add_child(unit)
		
	elif groups.has("Enemies"):
		scene.get_node("Enemies").add_child(unit)
		
	elif groups.has("Area"):
		print("Nigga, you adding areas now??")
		scene.get_node("City").add_child(unit)
	
	unit.area_component.set_area(current_spawn_area)
	
	get_action_manager().emit_signal("action_ended", self)