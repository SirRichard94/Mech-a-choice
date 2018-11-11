extends TextureRect


var pause_active = false

func _ready():
	pause_active = false
	visible = false

func _input(event):
	if event.is_action_pressed("pause"):
		pause_active = not pause_active
		visible = pause_active
		get_tree().paused = pause_active
		