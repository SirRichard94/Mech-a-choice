extends VBoxContainer

var TurnTracker = preload("res://GUI/TurnList/Turn Tracker.tscn")

export var max_trackers = 5

func _ready():
	update_trackers()

func sort_trackers():
	# insertion sort
	var trackers = get_children()
	var i = 1
	
	while i < trackers.size():
		var j = i
		while (j > 0) and compare( trackers[j-1], trackers[j] ) > 0 :
			move_child(trackers[j], j-1) #swap
			j = j-1
		i = i+1

func update_trackers():
	var i = 0
	
	for timer in get_tree().get_nodes_in_group("ATB Timers"):
		if i >= get_child_count():
			var t = TurnTracker.instance()
			t.target = timer
			add_child(t)
		else:
			get_child(i).target = timer
		i+=1
		if not timer.is_connected("timeout", self, "update_trackers"):
			timer.connect("timeout", self, "update_trackers")
		if not timer.owner.is_connected("died", self, "update_trackers"):
			timer.owner.connect("died", self, "update_trackers")
	
	sort_trackers()
	i = 0
	for tracker in get_children():
		if tracker.target.owner.is_dead():
			tracker.visible = false
		elif i > max_trackers:
			tracker.visible = false
		else:
			tracker.visible = true
			i+= 1

func compare(a, b): 
	return a.target.time_left - b.target.time_left
