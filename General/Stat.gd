extends Node

var maximum = 10 setget set_maximum
var current = 10 setget set_current
var current_level = 0

signal value_changed(old,new)
signal max_changed(old,new)

func set_maximum(new):
	var old = maximum
	maximum = new
	emit_signal("value_changed", old, new)

func set_current(new):
	var old = current
	new = max (new, maximum)
	current = new
	emit_signal("max_changed", old, new)

func level_up(amnt = 1):
	set_level(current_level + amnt)

func set_level(level):
	assert level >= 0
	current_level = min(level, get_child_count()-1)
	var old = maximum
	self.maximum = int(get_child(current_level).name) #set max stat to nth child
	self.current += maximum - old #add diference

func _ready():
	assert get_child_count() > 0
	set_level(0)
