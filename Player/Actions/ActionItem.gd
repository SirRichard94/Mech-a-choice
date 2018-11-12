extends Node

var description = """
	This Action Has a Description
"""
var energy_cost = 0

onready var gui = get_tree().current_scene.get_node("GUI")
onready var player = get_tree().current_scene.get_node("Player")
onready var ATBTimer = player.get_node("ATBTimer")

func _ready():
	pass

func _do_action():
	pass

func _on_hover():
	pass