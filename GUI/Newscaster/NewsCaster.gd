extends Control

onready var text_label = get_node("Newscaster/TextBox/RichTextLabel")

export var text_speed = 0.5
export var message_stay = 2
export var max_lines = 3

signal text_shown
signal message_ended

enum States {HIDDEN, SPEAKING}
var state = HIDDEN

var message_queue

func _ready():
	message_queue = DS.PriorityQueue.new([])
	text_label.percent_visible = 0


func announce(text, priority=3):
	message_queue.insert(priority, text)

func announce_multiple(arr, priority=3):
	for text in arr:
		message_queue.insert(priority, text)

func _process(delta):
	if message_queue.isEmpty or state == SPEAKING:
		return
	start_anouncement()

func start_anouncement():
	state = SPEAKING
	
	if message_queue.get_root_priority() <=1:
		pass # Breaking gets show when processing mesages
	else:
		$AnimationPlayer.play("Appear")
		yield($AnimationPlayer, "animation_finished")
	
	while not message_queue.isEmpty:
		var item = message_queue.remove_root(true)
		
		var message = item[1]
		var time = message_stay
		
		if item[0] <=1: #priority 1 messages: show breaking animation
			$AnimationPlayer.play("Breaking")
			yield($AnimationPlayer, "animation_finished")
		elif item[0] == 2: #priority 2 messages: show it alone
			pass
		else: #priority 3+ aggregate them in a single message
			var lines = text_label.get_line_count()
			while lines < max_lines-1 and message_queue.get_root_priority() > 2:
				item = message_queue.remove_root(true)
				message = message+"\n"+item[1]
				time += message_stay/2
				lines +=1
		
		show_text(message, time)
		yield(self, "text_shown")
	
	$AnimationPlayer.play("Disappear")
	yield($AnimationPlayer, "animation_finished")
	state = HIDDEN
	emit_signal("message_ended")

func show_text(text, time=2):
	text_label.text = text
	$Tween.interpolate_property(text_label, "percent_visible", 0,1,text_speed,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	$Tween.start()
	yield($Tween,"tween_completed")
	
	$Timer.wait_time = time
	$Timer.start()
	yield($Timer, "timeout")
	
	text_label.percent_visible = 0
	emit_signal("text_shown")