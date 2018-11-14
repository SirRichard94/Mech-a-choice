extends "res://General/Unit.gd"

onready var gui = get_tree().current_scene.get_node("GUI")

func _ready():
	$ATBTimer.connect("timeout", self, "choose_action")
	start_ATBTimer()

func add_shake(f):
	get_tree().current_scene.get_node("Camera").add_shake(f)

func choose_action():
	var action_menu = gui.action_menu
	var actions = $Actions.get_children()
	action_menu.title_text = "HERO CHOOSES BRAVE ACTION !"
	action_menu.menu_items = actions
	action_menu.appear()
	
	for timer in get_tree().get_nodes_in_group("ATB Timers"):
		timer.paused = true
	
	yield($Actions, "action_started")
	action_menu.disappear()
	yield($Actions, "action_ended")
	start_ATBTimer()

func start_ATBTimer(modifier = 1):
	for timer in get_tree().get_nodes_in_group("ATB Timers"):
		timer.paused = false
	var base_wait = 60/stats.get_current("Speed")
	
	$ATBTimer.wait_time = base_wait * modifier ## add city mod
	$ATBTimer.start()
	