extends "res://Components/fsm/fsm_state.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"


func on_init():
	fsm_owner.get_node("AnimationPlayer").play("Die")
	fsm_owner.get_node("ATBTimer").wait_time = 999
	yield(get_tree().create_timer(3), "timeout")
	queue_free()