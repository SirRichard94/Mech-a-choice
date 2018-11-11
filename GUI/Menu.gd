extends Control
var MenuItemTheme = preload("res://GUI/Menu Items/menu_theme.tres")

var menu_items = [] setget set_menu_items
var title_text = "HERO CHOOSES BRAVE ACTION !"

onready var title_label = $VBoxContainer/Title/MarginContainer/Label
onready var item_container = $"VBoxContainer/Rect/MarginContainer/HBoxContainer/ScrollContainer/Menu Items"
onready var description_box = $"VBoxContainer/Rect/MarginContainer/HBoxContainer/CenterContainer/RichTextLabel"

var menu_height = 250
var tween_time = 0.7

func set_menu_items(new):
	menu_items = new
	refresh_items()


func _ready():
	pass

func appear():
	visible = true
	
	$Tween.interpolate_property(self, "margin_top", margin_bottom, -menu_height
		, tween_time, Tween.TRANS_QUART, Tween.EASE_OUT )
	$Tween.start()
	
	yield($Tween,"tween_completed") #continue when completed
	
	item_container.get_child(0).grab_focus()

func disappear():
	
	$Tween.interpolate_property(self, "margin_top",-menu_height, margin_bottom
		, tween_time, Tween.TRANS_QUART, Tween.EASE_OUT )
	$Tween.start()
	release_focus()
	
	yield($Tween,"tween_completed") #continue when completed
	
	visible = false

func refresh_items():
	title_label.text = title_text
	
	for child in item_container.get_children(): #Child murder
		child.queue_free()
	
	for item in menu_items: #load items
		#MAKE BUTTONS
		var m_item = ToolButton.new()
		m_item.text = item.name
		m_item.theme = MenuItemTheme
		m_item.align = Button.ALIGN_LEFT
		
		# SET BEHAVIOUR
		m_item.connect("pressed", item, "_do_action")
		
		# SET DESCRITION
		var desc = item.get("description")
		if desc == null:
			desc = ""
		m_item.connect("focus_entered", description_box, "set",["text",desc])
		m_item.connect("mouse_entered", description_box, "set",["text",desc])
		
		item_container.add_child(m_item)
	
	yield(get_tree(),"idle_frame")
	item_container.get_child(0).grab_focus()