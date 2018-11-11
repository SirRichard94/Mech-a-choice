extends "res://Player/Actions/ActionItem.gd"

func _ready():
	description = "Basic attack for X damage and X City Damage"

func _do_action():
	player.action_menu.disappear()
	animator.play("Punch")
	yield(animator,"animation_finished")
	animator.play("Idle")
	player.start_ATBTimer()