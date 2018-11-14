extends Node
var ActionManager = preload("res://Components/ActionsManager.gd")

var description = "This Action Has a Description"
var energy_cost = 0

signal action_started #When a signiificant action begins
signal action_ended	#When a signiificant action ends

onready var gui = get_tree().current_scene.get_node("GUI")
onready var player = get_tree().current_scene.get_node("Player")

func _ready():
	connect("action_started", get_action_manager(), "emit_signal", ["action_started", self])
	connect("action_ended", get_action_manager(), "emit_signal", ["action_ended", self])

func get_action_manager():
	var current_parent = get_parent()
	while not (current_parent is ActionManager):
		if current_parent == get_tree().current_scene:
			print ("Error: Action is not under of Action_Manager")
			return null
		current_parent = current_parent.get_parent()
	return current_parent

func _do_action():
	pass

func _on_hover():
	pass

func is_disabled():
	return false