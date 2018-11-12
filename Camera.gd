extends Node2D

export var shake_x = 250.0
export var shake_y = 300.0
export var max_shake_time = 2.0
export var max_rotation = .04

var trauma = 0

func add_shake(f):
	trauma+=f

func _process(delta):
	var new_trauma =  trauma - delta/max_shake_time
	trauma = clamp(new_trauma,0,1.0)
	
	$Camera2D.position.x = pow(trauma,3) * (randf()*2 -1 ) * shake_x
	$Camera2D.position.y = pow(trauma,3) * (randf()*2 -1 ) * shake_y
	$Camera2D.rotation = PI * pow(trauma,3) * (randf()*2 -1 ) * max_rotation