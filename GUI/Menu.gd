extends NinePatchRect

var MenuItemPrefab = preload("res://GUI/MenuItem.tscn")

var menu_items = []
var i_selected = 0

var pos_in = Vector2(71,350)
var pos_out = Vector2(71,700)
var tween_time = 1.0

func _ready():
	$Tween.interpolate_property(self, "rect_position", pos_out, pos_in, tween_time, Tween.TRANS_BOUNCE, Tween.EASE_OUT )
	$Tween.start()
	refresh_items()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$Tween.interpolate_property(self, "rect_position", pos_in, pos_out, tween_time, Tween.TRANS_CUBIC, Tween.EASE_OUT )
		$Tween.start()
	if event.is_action_pressed("ui_accept"):
		if menu_items[i_selected].has_method("doit_faggot"):
			menu_items[i_selected].doit_faggot()
			$Tween.interpolate_property(self, "rect_position", pos_in, pos_out, tween_time, Tween.TRANS_CUBIC, Tween.EASE_OUT )
			$Tween.start()
		
	if event.is_action_pressed("ui_down"):			
		var cont = $"MarginContainer/ScrollContainer/Menu Items"
		cont.get_child(i_selected).get_node("Cursor").visible = false
		i_selected = (i_selected +1) % menu_items.size()
		cont.get_child(i_selected).get_node("Cursor").visible = true
		
	if event.is_action_pressed("ui_up"):
		
		var cont = $"MarginContainer/ScrollContainer/Menu Items"
		cont.get_child(i_selected).get_node("Cursor").visible = false
		i_selected = (max(i_selected-1,0)) % menu_items.size()
		cont.get_child(i_selected).get_node("Cursor").visible = true
	
	
func refresh_items():
	var cont = $"MarginContainer/ScrollContainer/Menu Items"
	
	for child in cont.get_children(): #Child murder
		child.queue_free()
	
	for item in menu_items: #load items
		var m_item = MenuItemPrefab.instance()
		m_item.get_node("Label").text = item.name
		m_item.get_node("Label").name = item.name
		#m_item.reference = item
		cont.add_child(m_item)