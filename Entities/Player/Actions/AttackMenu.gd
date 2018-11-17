extends "res://Entities/Player/Actions/MenuAction.gd"

func is_disabled():
	return owner.get_node("AreaComponent").get_area().enemy_count() == 0