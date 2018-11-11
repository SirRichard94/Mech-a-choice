extends Node2D


onready var city = get_node("../City")
onready var gui = get_node("../GUI")
onready var action_menu = gui.get_node(gui.action_menu)

var actions_per_minute = 2.0

var ac_wait

func _ready():
	$ATBTimer.wait_time = actions_per_minute/60
	$ATBTimer.connect("timeout", self, "choose_action")
	$ATBTimer.start()
	

func choose_action():
	var actions = $Actions.get_children()
	
	action_menu.menu_items = actions
	action_menu.refresh_items()
	action_menu.appear()
	
	for timer in get_tree().get_nodes_in_group("ATB Timers"):
		timer.paused = true
	
	ac_wait = yield()
	
	$ATBTimer.start()