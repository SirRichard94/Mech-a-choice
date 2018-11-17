extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _input(event):
	if event.is_action_pressed("open_map"):
		visible = not visible
		$"Map Panel/Trackers".update()
