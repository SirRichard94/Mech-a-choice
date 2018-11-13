extends "res://City/Area.gd"

onready var player = get_tree().current_scene.get_node("Player")

func _on_ATBTimer_timeout():
	var player_stats = player.get_node("StatBlock")
	player_stats.add("Energy", 1)
	print("added_energy")
