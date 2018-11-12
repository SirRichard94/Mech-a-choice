extends "res://Player/Actions/ActionItem.gd"

var target

func _ready():
	if target == null:
		queue_free()
		print ("invalid location")
		return
	description = target.name

func _do_action():
	gui.action_menu.disappear()
	
	var animator = player.get_node("AnimationPlayer")
	if player.location.enemy_count() > 0:
		animator.play("Retreat")
	else:
		animator.play("Leave")
	
	yield(animator,"animation_finished")
	
	player.location = target
	get_tree().current_scene.set_current_area(target)
	
	animator.play("Arrive") 
	
	yield(animator,"animation_finished")
	
	animator.play("Idle") 
	player.start_ATBTimer()