extends Timer


func _ready():
	owner = get_parent()
	yield(get_tree(),"idle_frame") #make sure everything loaded
	var stats = owner.get_node("StatBlock")
	if stats:
		self.wait_time = 60/stats.get_current("Speed")
