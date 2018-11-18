extends Node

var t = 0
var target = 50

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	t+= delta
	if t > target:
		t = 0
		target = rand_range(20,70)
		var areas = get_tree().get_nodes_in_group("Areas")
		
		var area = GlobalUtilities.get_area(areas[randi()%areas.size()].name)
		GlobalUtilities.broadcast_message("King Ape Spawning on "+area.name, 0)
		$Actions/SpawnKing.spawn_area = area.name
		$Actions.do_action("SpawnKing", false)
		
		get_tree().current_scene.set_current_area(area.name, 2)
