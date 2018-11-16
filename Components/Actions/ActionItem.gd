extends Node
var ActionManager = preload("res://Components/Actions/ActionsManager.gd")

enum TargetType {PLAYER, CITY, ALLY, ENEMY, SELF }

export var ends_action = true
export var energy_cost = 0
export var description = "This Action Has a Description"  setget , _get_description
export (TargetType) var target_type = PLAYER

onready var gui = get_tree().current_scene.get_node("GUI")
onready var player = get_tree().current_scene.get_node("Player")

var is_menu_action = false

func _ready():
	owner = get_action_manager().owner

func get_action_manager():
	var current_parent = get_parent()
	while not (current_parent is ActionManager):
		if current_parent == get_tree().current_scene:
			print ("Error: Action is not under of Action_Manager")
			return null
		current_parent = current_parent.get_parent()
	return current_parent

func do_action():
	var f_reff = _do_action()
	
	# TODO this is good enough... for now
	# Change it to wait for the signal...sigh
	while f_reff != null and f_reff.is_valid():
		yield(get_tree(), "idle_frame")
	
	if ends_action:
		get_action_manager().emit_signal("action_ended", self)

func _get_description():
	return description

func _do_action():
	pass

func _on_hover():
	pass

func is_disabled():
	return false