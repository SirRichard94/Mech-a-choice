extends Node

signal action_started(action)
signal action_ended(action)

func _ready():
	owner = get_parent()
	for child in get_children():
		child.owner = owner

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
