extends "res://Components/Actions/ActionItem.gd"




export var damage = 3
export var colateral_damage = 1
export (String) var tags = "physical, melee"


export (String) var animation = null
export var animation_has_event = false
export (String) var end_animation = null

func is_disabled():
	return get_target() == null

func get_target():
	var target
	var area = owner.get_node("AreaComponent").get_area()
	match target_type: 
		PLAYER:
			target= area.get_player()
		CITY:
			target = area
		ALLY: # TODO: change to target specific ally
			target = null if area.get_allies().empty() else area.get_allies()[0]
		ENEMY: # TODO: change to target specific enemy
			target = null if area.get_enemies().empty() else area.get_enemies()[0]
		SELF: 
			target = owner
	return target

func _do_action():
	var target = get_target()
	if target == null:
		get_action_manager().emit_signal("action_ended", self)
		print("No Target")
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

	get_action_manager().emit_signal("action_ended", self)