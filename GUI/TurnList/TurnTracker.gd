extends Control

var target setget set_target, get_target
var area setget , get_area

func get_area():
	return area if area==null else area.get_ref()
func get_target():
	return target if target == null else target.get_ref()

func set_target(new):
	if not new.is_in_group("ATB Timers") or not new.get("show_in_tracker"):
		target = null
		return
		
	target = new
	
	$Label.text = target.owner.unit_name
	name = target.owner.name
	
	if target.owner.is_in_group("Areas"):
		area = target.owner
	elif target.owner.get_node("AreaComponent"):
		area = target.owner.get_node("AreaComponent").get_area()
	
	if area != null:
		$Icon.texture = area.icon
	
	area = weakref(area)
	target = weakref(target)

func remove_target():
	target = null
	area = null
	visible = false

func is_target_valid():
	return get_target() != null and get_target().show_in_tracker

func get_priority():
	if self.target:
		var t = self.target
		var priority = -t.time_left
		if t.is_in_group("Player"):
			priority += 500
		if GlobalUtilities.get_current_area() == area:
			priority += 50
		return priority
	else:
		remove_target()
		return -INF

func _process(delta):
	if not is_target_valid() or not visible:
		return
	
	$Progress.min_value = 0
	$Progress.max_value = self.target.wait_time
	$Progress.value = self.target.time_left