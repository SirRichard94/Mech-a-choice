extends Control

export (NodePath) var action_menu
export (NodePath) var pause_menu

func _ready():
	assert action_menu != null
	assert pause_menu != null

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
