extends Node2D

onready var stats = get_node("StatBlock")

export var screen_shake_modifier = 1.0

signal unit_died

func _ready():
	print("hi "+name)
	assert stats != null
	assert is_in_group("Enemies") or is_in_group("Alies") or is_in_group("Areas") or is_in_group("Player")
	

func take_damage(damage):
	assert stats.has_stat("HP")
	var shake = 0
	if stats.has_stat("Shield") and stats.get_current("Shield") > 0:
		# Armor halves energy damage
		# Soaks the damage instead of the HP
		var dmg = ceil(damage.amount/2) if damage.tags.has("Energy") else damage.amount
		stats.add("shield", -dmg)
		shake = dmg /20.0
	elif stats.has_stat("Armor") and stats.get_current("Armor") >0:
		# Armor reduces damage to a min of 1
		var dmg = damage.amount
		if damage.tags.has("Energy"):
			max(1, damage.amount - stats.get_current("Armor")) 
		stats.add("HP", -dmg)
		shake = dmg /10.0
	else:
		# just take it
		var dmg = damage.amount
		stats.add("HP", -dmg)
		shake = dmg /10.0
	var cam = get_tree().current_scene.get_node("Camera")
	cam.add_shake(shake*screen_shake_modifier)
	
	if is_dead():
		emit_signal("unit_died")
		# micro pause the game based on how much hp the dead guy had
		get_tree().pause = true
		get_tree().create_timer(0.05*stats.get_max("HP"), true)
		get_tree().pause = false
	
func is_dead():
	return stats.get_current("HP") <=0