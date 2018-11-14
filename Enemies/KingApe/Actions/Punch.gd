extends "res://Components/ActionItem.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _do_action():
	emit_signal("action_started")
	
	var animator = owner.get_node("AnimationPlayer")
	animator.play("Punch")
	
	yield(animator,"animation_event")

	owner.attack(player, 3)

	yield(animator,"animation_finished")
	animator.play("Idle")
	
	emit_signal("action_ended")