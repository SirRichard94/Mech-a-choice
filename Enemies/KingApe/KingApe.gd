extends "res://General/Unit.gd"


func _ready():
	$ATBTimer.connect("timeout",self, "_on_ATB_timeout")

func _on_ATB_timeout():
	print ("Ape turn!")
	var player = get_tree().get_nodes_in_group("Player")[0]
	
	if player.is_dead():
		$AnimationPlayer.play("Taunt")
		return
	
	$Actions.do_action("Punch")
	
	yield($Actions,"action_ended")
	$ATBTimer.start()