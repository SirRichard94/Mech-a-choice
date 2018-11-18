extends Timer

export var show_in_tracker = true

func _ready():
	owner = get_parent()
	yield(get_tree(),"idle_frame") #make sure everything loaded
	var stats = owner.get_node("StatBlock")
	if stats:
		self.wait_time = 60/stats.get_current("Speed")
	else:
		self.wait_time = rand_range(1,4)