extends "res://Components/ActionItem.gd"

enum TargetType {PLAYER, CITY, ALLY, ENEMY }

export var damage = 3
export var colateral_damage = 1
export (String) var tags = "physical, melee"
export (String) var animation
export (TargetType) var target

func _do_action():
	emit_signal("action_started")
	
	var animator = owner.get_node("AnimationPlayer")
	animator.play("Punch")
	
	yield(animator,"animation_event")

	owner.attack(player, 3)

	yield(animator,"animation_finished")
	animator.play("Idle")
	
	emit_signal("action_ended")