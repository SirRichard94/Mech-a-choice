extends Node

var stats = {}

signal stat_current_changed(stat)
signal stat_max_changed(stat)

func _ready():
	owner = get_parent()
	for stat_node in get_children():
		var stat = {}
		stat["name"] = stat_node.name
		stat["level_value"] = []
		for node in stat_node.get_children():
			stat.level_value.append( int(node.name) )
		
		stat["level"] = 0
		stat["max"] = stat.level_value[0]
		stat["current"] = stat.max
		stats[stat.name] = stat
		# First Stat is default, 2nd is the actual first level
		set_level(stat.name, 1 if stat.level_value.size() > 1 else 0)

func get_stat(stat_name):
	var stat = stats[stat_name]
	if stat == null:
		print("Stat \""+ stat_name + "\" not found in node " + owner.get_name() )
	return stat

func get_current(stat_name):
	var stat = get_stat(stat_name)
	if stat == null:
		return false
	return stat.current

func get_max(stat_name):
	var stat = get_stat(stat_name)
	if stat == null:
		return false
	return stat.max

func has_stat(stat_name):
	return stats.has(stat_name)
	
func set_max(stat_name, value):
	var stat = get_stat(stat_name)
	if stat == null:
		return false
	
	var old = stat.max
	stat.max = value
	set_current(stat_name, stat.current + value - old ) #add diference
	emit_signal("stat_max_changed", stat)

func add(stat_name, value):
	var stat = get_stat(stat_name)
	if stat == null:
		return false
	set_current(stat_name, stat.current+value)

func set_current(stat_name, value):
	var stat = get_stat(stat_name)
	if stat == null:
		return false
	
	var new = max (value, stat.max)
	stat.current = value
	emit_signal("stat_current_changed", stat)

func set_level(stat_name, value):
	var stat = get_stat(stat_name)
	if stat == null:
		return false
	
	stat.level = clamp(value, 0, stat.level_value.size()-1)
	set_max(stat.name, stat.level_value[stat.level] )