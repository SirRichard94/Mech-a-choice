extends "res://General/Unit.gd"

func _ready():
	$ATBTimer.connect("timeout", self, "choose_action")
	start_ATBTimer()

func add_shake(f):
	GlobalUtilities.screen_shake(f)

func _on_death():
	self.visible = false
	$ATBTimer.paused = true
	gui.newscaster.announce("HERO HAS DIED", 1)

func choose_action():
	start_ATBTimer()
	$Actions.do_action("Menu")

func start_ATBTimer(modifier = 1):
	
	var base_wait = 60/stats.get_current("Speed")
	
	$ATBTimer.wait_time = base_wait * modifier ## add city mod
	$ATBTimer.start()
	