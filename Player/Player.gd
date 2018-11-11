extends Node2D

onready var city = get_node("../City")
onready var gui = get_node("../GUI")
onready var action_menu = gui.get_node(gui.action_menu)

func _ready():
	$ATBTimer.connect("timeout", self, "choose_action")
	start_ATBTimer()

func choose_action():
	var actions = $Actions.get_children()
	action_menu.title_text = "HERO CHOOSES BRAVE ACTION !"
	action_menu.menu_items = actions
	action_menu.appear()
	
	for timer in get_tree().get_nodes_in_group("ATB Timers"):
		timer.paused = true

func start_ATBTimer(modifier = 1):
	for timer in get_tree().get_nodes_in_group("ATB Timers"):
		timer.paused = false
	
	$ATBTimer.wait_time = $"StatBlock/ATB Base".current * modifier ## add city mod
	$ATBTimer.start()