extends Control

var target setget set_target
var area

func set_target(new):
	if not new.is_in_group("ATB Timers"):
		target = null
		return
		
	target = new
	
	$Label.text = target.owner.name
	name = target.owner.name
	
	if new.owner.is_in_group("Areas"):
		area = target.owner
	elif target.owner.get_node("AreaComponent"):
		area = target.owner.get_node("AreaComponent").get_area()
	
	if area != null:
		$Icon.texture = area.icon


func _ready():
	self.target = get_tree().current_scene.get_node("Player/ATBTimer") #test

func _process(delta):
	if not visible or target == null:
		return
	
	$Progress.min_value = 0
	$Progress.max_value = target.wait_time
	$Progress.value = target.time_left