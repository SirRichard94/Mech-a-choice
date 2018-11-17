extends Container

var TurnTracker = preload("res://GUI/TurnList/Turn Tracker.tscn")

export var max_visible_trackers = 5
var being_tracked=[]

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

func _process(delta):
	update_trackers()

func update_trackers():
	for timer in get_tree().get_nodes_in_group("ATB Timers"):
		if being_tracked.has(timer):
			pass
		else:
			var t = TurnTracker.instance()
			t.target = timer
			add_child(t)
			being_tracked.append(timer)

	sort_trackers()

	var i = 0
	for tracker in get_children():
		if not tracker.is_target_valid():
			tracker.queue_free()
		elif i > max_visible_trackers:
			tracker.visible = false
		else:
			tracker.visible = true
			i+= 1

func compare(a, b): 
	return b.get_priority() - a.get_priority()  
