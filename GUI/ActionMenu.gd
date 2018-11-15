extends Control
var MenuItemTheme = preload("res://GUI/Menu Items/menu_theme.tres")
var ActionItem = preload("res://Components/Actions/ActionItem.gd")

signal action_chosen(action)

onready var title_label = $Title/MarginContainer/Label
onready var item_container = $"Rect/MarginContainer/HBoxContainer/ScrollContainer/Menu Items"
onready var description_box = $"Rect/MarginContainer/HBoxContainer/CenterContainer/RichTextLabel"

var menu_items = [] setget set_menu_items
var title_text = "HERO CHOOSES BRAVE ACTION !"

var active = false setget set_active, is_active

func do_action(action):
	if not action.is_menu_action:
		self.active = false
	
	action.get_action_manager().do_action(action)
	emit_signal("action_chosen", action)

func set_active(v):
	if v:
		if not active:
			appear()
		active = true
	else:
		if active:
			disappear()
		active = false

func is_active():
	return active

func appear():
	visible = true
	item_container.get_child(0).grab_focus()

func disappear():
	release_focus()
	visible = false

func set_menu_items(new):
	menu_items = new
	refresh_items()

func _ready():
	visible = false

func refresh_items():
	title_label.text = title_text
	
	for child in item_container.get_children(): #Child murder
		child.queue_free()
	
	for item in menu_items: #load items
		#MAKE BUTTONS
		var action_button = ToolButton.new()
		action_button.text = item.name
		action_button.theme = MenuItemTheme
		action_button.align = Button.ALIGN_LEFT
		
		# SET BEHAVIOUR
		if item is ActionItem:
			action_button.connect("pressed", self, "do_action", [item])
		
		# SET DESCRITION
		var desc = item.get("description")
		action_button.connect("focus_entered", description_box, "set",["text",desc])
		action_button.connect("mouse_entered", description_box, "set",["text",desc])
		
		# SET DISABLED
		var disabled = item.is_disabled() if item.has_method("is_disabled")  else true
		action_button.disabled = disabled
		
		#Add button
		item_container.add_child(action_button)
	
	#grab focus
	yield(get_tree(),"idle_frame")
	item_container.get_child(0).grab_focus()