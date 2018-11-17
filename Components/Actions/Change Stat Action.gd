extends "res://Components/Actions/ActionItem.gd"

export var stat_name = "HP"
export var value = 1
export var temp_time = -1
export var is_level_change = false
export var is_multiplier = false
export var is_relative = true

export (String) var animation = null
export (String) var end_animation = null

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _do_action():
	var target = get_target()
	if not target:
		print ("Change stat: No target")
		end_action()
		return
	
	var animation_player = owner.get_node("AnimationPlayer")
	if animation!= null and animation_player != null:
		animation_player.play(animation)
		yield(animation_player,"animation_finished")
		
	
	var stats = target.stats
	
	var final_value = stats.get_current(stat_name) 
	if is_multiplier:
		final_value = final_value * value
	elif is_relative:
		final_value = final_value + value
	else:
		final_value = value
	
	if is_level_change:
		stats.set_level(stat_name, value + stats.get_level() if is_relative else value)
	else:
		if temp_time > 0:
			stats.set_temp(stat_name, final_value, temp_time, is_relative)
		else:
			stats.set_current(stat_name, final_value)
	
	if end_animation!= null and animation_player != null:
		animation_player.play(end_animation)
		yield(animation_player,"animation_finished")
	
	end_action()