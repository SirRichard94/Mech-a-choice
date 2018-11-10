extends Control
var MenuItemTheme = preload("res://GUI/Menu Items/menu_theme.tres")

var menu_items = []
var title_text = "HERO CHOOSES BRAVE ACTION !"

onready var title_label = $VBoxContainer/Title/MarginContainer/Label
onready var item_container = $"VBoxContainer/Rect/MarginContainer/HBoxContainer/ScrollContainer/Menu Items"

var menu_height = 250
var tween_time = 0.7

func _ready():
	$EnterTween.interpolate_property(self, "margin_top", margin_bottom, -menu_height, tween_time, Tween.TRANS_BOUNCE, Tween.EASE_OUT )
	$ExitTween.interpolate_property(self, "margin_top",-menu_height, margin_bottom, tween_time, Tween.TRANS_EXPO, Tween.EASE_OUT )

func appear():
	visible = true
	$EnterTween.start()
	yield($EnterTween,"tween_completed") #continue when completed
	item_container.get_child(0).grab_focus()

func disappear():
	$ExitTween.start()
	release_focus()
	yield($ExitTween,"tween_completed") #continue when completed
	visible = false

func refresh_items():
	title_label.text = title_text
	
	for child in item_container.get_children(): #Child murder
		child.queue_free()
	
	for item in menu_items: #load items
		var m_item = ToolButton.new()
		m_item.text = item.name
		m_item.theme = MenuItemTheme
		m_item.align = Button.ALIGN_LEFT
		
		m_item.connect("pressed", item, "doit_faggot")
		m_item.connect("pressed", self, "disappear")
		
		item_container.add_child(m_item)