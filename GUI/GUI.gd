extends CanvasLayer

var action_menu_path = "Main/Screen/Menu Area/Container/Menu"
var pause_menu_path = "Pause"
var newscaster_path = "NewsCaster"

var action_menu
var pause_menu
var newscaster

func _ready():
	action_menu = get_node(action_menu_path)
	pause_menu = get_node(pause_menu_path)
	newscaster = get_node(newscaster_path)
	
	assert action_menu != null
	assert pause_menu != null
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
