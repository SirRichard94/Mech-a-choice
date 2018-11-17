extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
		update()


func _draw():
	for node in get_children():
		if node.area != null:
			for path in node.area.get_node("Paths").get_children():
				var a = node
				var b = get_node(path.name)
				if b != null:
					var from = a.position
					var to = b.position
					draw_line(from, to, Color(1,1,1), 4, true)