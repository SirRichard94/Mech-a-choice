extends Timer


func _ready():
	owner = get_parent()
	add_to_group("ATB Timers")
	#if get_parent().has_method("_on_ATB_timeout"):
	#	connect("timeout", get_parent(), "_on_ATB_timeout")
