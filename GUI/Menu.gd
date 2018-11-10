extends Control

var MenuItemPrefab = preload("res://GUI/MenuItem.tscn")

var menu_items = []
var title_text = "HERO CHOOSES BRAVE ACTION !"

onready var title_label = $VBoxContainer/Title/MarginContainer/Label
onready var item_container = $"VBoxContainer/Rect/MarginContainer/HBoxContainer/ScrollContainer/Menu Items"

var i_selected = 0

var menu_height = 250
var tween_time = 1.0

func _ready():
	$EnterTween.interpolate_property(self, "margin_top", margin_bottom, -menu_height, tween_time, Tween.TRANS_BOUNCE, Tween.EASE_OUT )
	$ExitTween.interpolate_property(self, "margin_top",-menu_height, margin_bottom, tween_time, Tween.TRANS_EXPO, Tween.EASE_OUT )
	refresh_items()
	
	
	appear()

func appear():
	$EnterTween.start()

func disappear():
	$ExitTween.start()
	#yield($ExitTween, "tween_completed") #wait until completed tween


func _input(event):
	if event.is_action_pressed("ui_accept"):
		if menu_items[i_selected].has_method("doit_faggot"):
			menu_items[i_selected].doit_faggot()
			disappear()
		
	if event.is_action_pressed("ui_down"):			
		
		item_container.get_child(i_selected).get_node("Cursor").visible = false
		i_selected = (i_selected +1) % menu_items.size()
		item_container.get_child(i_selected).get_node("Cursor").visible = true
		
	if event.is_action_pressed("ui_up"):
		item_container.get_child(i_selected).get_node("Cursor").visible = false
		i_selected = (max(i_selected-1,0)) % menu_items.size()
		item_container.get_child(i_selected).get_node("Cursor").visible = true
	
	
func refresh_items():
	title_label.text = title_text
	
	for child in item_container.get_children(): #Child murder
		child.queue_free()
	
	for item in menu_items: #load items
		var m_item = MenuItemPrefab.instance()
		m_item.get_node("Label").text = item.name
		m_item.get_node("Label").name = item.name
		#m_item.reference = item
		item_container.add_child(m_item)