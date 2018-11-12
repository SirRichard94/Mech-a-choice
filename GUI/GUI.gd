extends CanvasLayer

export (NodePath) var action_menu_path = "Container/Container/Menu Panel"
export (NodePath) var pause_menu_path = "Pause"

var action_menu
var pause_menu

func _ready():
	action_menu = get_node(action_menu_path)
	pause_menu = get_node(pause_menu_path)
	
	assert action_menu != null
	assert pause_menu != null
	
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
