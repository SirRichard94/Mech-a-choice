extends "res://City/Area.gd"

onready var player = get_tree().current_scene.get_node("Player")

func _on_ATB_turn():
	var player_stats = player.get_node("StatBlock")
	player_stats.get_node("Energy").current += 10
	print("added_energy")