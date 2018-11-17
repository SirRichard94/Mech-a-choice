extends Node

var area

onready var atb_bar = $ATBBar
onready var icon =  $ATBBar/Container/Icon
onready var name_tag = $NameTag
onready var hp_tag = $HPTag

export var critical_color= Color(1,0,0)
export var damaged_color = Color(0.7,0.7,0)

func _ready():
	area = GlobalUtilities.get_area(name)
	
	if area == null:
		return
	icon.texture = area.icon
	name_tag.text = area.unit_name

func _process(delta):
	update()

func update():
	if area == null:
		return
	
	var timer = area.get_node("ATBTimer")
	var hp = area.stats.get_current("HP")
	var hp_max = area.stats.get_max("HP")
	var hp_ratio = float(hp)/float(hp_max)
	var color = Color(1.0,1.0,1.0)
	color = critical_color.linear_interpolate(color, hp_ratio) if hp > 0 else Color(0.3,0.3,0.3)
	
	atb_bar.self_modulate = color	
	atb_bar.min_value = 0
	atb_bar.max_value = timer.wait_time
	atb_bar.value = timer.time_left
	
	icon.self_modulate = color
	
	hp_tag.text = "HP: "+str(hp)+"/" + str(hp_max)
	
	$PlayerIcon.visible = area.get_player() != null
	$EnemyIcon.visible = not area.get_enemies().empty()
	$AllyIcon.visible = not area.get_allies().empty()