extends Node2D

export var stat_name = "HP"
export var color = Color(0.6,0.0,0.0) setget _set_color

func _set_color(col):
	color = col
	self_modulate = col

func _ready():
	owner = get_parent()
	_set_color(color)
	$Name.text = stat_name
	yield(get_tree(), "idle_frame")
	owner.stats.connect("stat_changed",self, "_on_stat_changed")
	update_values()

func update_values():
	$Max.text = str( owner.stats.get_max(stat_name) )
	$Current.text = str( owner.stats.get_current(stat_name) )

func _on_stat_changed(stat):
	if stat == stat_name:
		update_values()