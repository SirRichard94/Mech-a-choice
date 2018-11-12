extends Node2D

export var shake_x = 100.0
export var shake_y = 70

var trauma = 1


func _process(delta):
	var new_trauma = trauma - trauma*0.5 *delta
	trauma = max(0,new_trauma)
	
	$Camera2D.position.x = position.x + trauma * randf() * shake_x
	$Camera2D.position.y = position.y + trauma * randf() * shake_y