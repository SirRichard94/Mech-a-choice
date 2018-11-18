extends Node
var ActionManager = preload("res://Components/Actions/ActionsManager.gd")

enum TargetType {PLAYER, CITY, ALLY, ENEMY, SELF }

export var ends_action = true
export var energy_cost = 0
export var description = "This Action Has a Description"  setget , _get_description
export (TargetType) var target_type = TargetType.PLAYER
export var local = true

signal action_ended

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

func get_target():
	var target_type = self.target_type if self.target_type != null else TargetType.SELF
	var target
	var area = owner.get_area()
	
	if local:
		match target_type: 
			PLAYER:
				target= area.get_player()
			CITY:
				target = area
			ALLY: # TODO: change to target specific ally
				target = null if area.get_allies().empty() else area.get_allies()[0]
			ENEMY: # TODO: change to target specific enemy
				target = null if area.get_enemies().empty() else area.get_enemies()[0]
			SELF: 
				target = owner
	else:
		match target_type: 
			PLAYER:
				target= get_tree().get_nodes_in_group("Player")[0]
			CITY:
				target = get_tree().get_nodes_in_group("Areas")[0]
			ALLY: # TODO: change to target specific ally
				target = get_tree().get_nodes_in_group("Allies")[0]
			ENEMY: # TODO: change to target specific enemy
				target = get_tree().get_nodes_in_group("Enemies")[0]
			SELF: 
				target = owner

	return target

func start_action():
	call_deferred("_do_action")

func end_action():
	emit_signal("action_ended")
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