extends "res://Components/Actions/ActionItem.gd"

export var damage = 3
export var colateral_damage = 1
export (String) var tags = "physical, melee"


export (String) var animation = null
export var animation_has_event = false
export (String) var end_animation = null

func is_disabled():
	return get_target() == null

func _do_action():
	var target = get_target()
	if target == null:
		print("No Target")
		end_action()
		return
	
	
	var animator = owner.get_node("AnimationPlayer")
	if animation != null:
		animator.play(animation)
		if animation_has_event:
			yield(animator,"animation_event")
		else :
			yield(animator,"animation_finished")
	
	var area = owner.get_node("AreaComponent").get_area()
	owner.attack(target, damage, tags.split(",",false))
	owner.attack(area, colateral_damage, ["colateral"])
	
	if animator.is_playing():
		yield(animator,"animation_finished")
	
	if end_animation != null:
		animator.play(end_animation)
	
	end_action()
	