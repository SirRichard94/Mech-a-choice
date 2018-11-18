extends "res://Components/Actions/ActionItem.gd"

export (String) var target_area = null
export var chase = false
export var chase_time = -1
export (String) var leave_animation = null
export (String) var retreat_animation = null
export (String) var arrive_animation = null
export (String) var end_animation = null

func _get_description():
	description = target_area

func _do_action():
	if target_area == null:
		print ("Move Action: WTF dude, this area is literally non existant")
		end_action()
		return false

	var area_comp = owner.get_node("AreaComponent")
	var animator = owner.get_node("AnimationPlayer")
	
	if animator:
		if area_comp.get_area().enemy_count() > 0:
			if retreat_animation:
				animator.play(retreat_animation)
				yield(animator,"animation_finished")
			elif leave_animation:
					animator.play(leave_animation)
					yield(animator,"animation_finished")
		elif leave_animation:
			animator.play(leave_animation)
			yield(animator,"animation_finished")
	
	area_comp.set_area( target_area )
	if chase:
		get_tree().current_scene.set_current_area(target_area, chase_time)
	
	if animator and arrive_animation:
		animator.play(arrive_animation) 
		yield(animator,"animation_finished")
	if animator and end_animation:
		animator.play(end_animation) 
	
	end_action()