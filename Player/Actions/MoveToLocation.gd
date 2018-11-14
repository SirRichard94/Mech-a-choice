extends "res://Player/Actions/ActionItem.gd"

var target

func _ready():
	if target == null:
		queue_free()
		print ("invalid location")
		return
	description = target.name

func _do_action():
	emit_signal("action_started")
	
	var area_comp = player.get_node("AreaComponent")
	var animator = player.get_node("AnimationPlayer")
	
	if area_comp.get_area().enemy_count() > 0:
		animator.play("Retreat")
	else:
		animator.play("Leave")
	
	yield(animator,"animation_finished")
	
	area_comp.set_area( target.name )
	get_tree().current_scene.set_current_area(target.name)
	
	animator.play("Arrive") 
	
	yield(animator,"animation_finished")
	
	animator.play("Idle") 
	emit_signal("action_ended")