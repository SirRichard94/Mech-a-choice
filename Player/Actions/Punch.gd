extends "res://Player/Actions/ActionItem.gd"

func _ready():
	description = "Basic attack for X damage and X City Damage"

func get_target():
	var area = player.get_node("AreaComponent").get_area()
	return area.get_enemies()[0]

func is_disabled():
	var area = player.get_node("AreaComponent").get_area()
	return area.get_enemies().empty()

func _do_action():
	gui.action_menu.disappear()
	
	var animator = player.get_node("AnimationPlayer")
	animator.play("Punch")
	
	yield(animator,"animation_event")

	owner.attack(get_target(), 3)

	yield(animator,"animation_finished")
	animator.play("Idle")
	
	player.start_ATBTimer()