extends "res://Player/Actions/ActionItem.gd"

func _ready():
	description = "Basic attack for X damage and X City Damage"

func _do_action():
	gui.action_menu.disappear()
	
	var animator = player.get_node("AnimationPlayer")
	animator.play("Punch")
	
	yield(animator,"animation_finished")
	
	animator.play("Idle")
	
	player.start_ATBTimer()