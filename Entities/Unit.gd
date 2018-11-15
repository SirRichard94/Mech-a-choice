extends Node2D

onready var gui = get_tree().current_scene.get_node("GUI")
onready var stats = get_node("StatBlock")

export var screen_shake_modifier = 1.0

signal died
signal taken_damage

func _ready():
	assert stats != null
	assert is_in_group("Enemies") or is_in_group("Alies") or is_in_group("Areas") or is_in_group("Player")

func _on_death():
	queue_free()

func _on_damage_taken(damage):
	gui.newscaster.announce(self.name + " has taken " + str(damage.amount) + " Damage")

func attack(unit, amount, tags = ["physical", "melee"]):
	var dmg = {}
	dmg["amount"] = amount
	dmg["source"] = self
	dmg["tags"] = tags
	unit.take_damage(dmg)

func take_damage(damage):
	assert stats.has_stat("HP")
	var shake = 0
	if stats.has_stat("Shield") and stats.get_current("Shield") > 0:
		# Armor halves energy damage
		# Soaks the damage instead of the HP
		var dmg = ceil(damage.amount/2) if damage.tags.has("energy") else damage.amount
		stats.add("Shield", -dmg)
		shake = dmg /20.0
	elif stats.has_stat("Armor") and stats.get_current("Armor") >0:
		# Armor reduces damage to a min of 1
		var dmg = damage.amount
		if damage.tags.has("energy"):
			max(1, damage.amount - stats.get_current("Armor")) 
		stats.add("HP", -dmg)
		shake = dmg /10.0
	else:
		# just take it
		var dmg = damage.amount
		stats.add("HP", -dmg)
		shake = dmg /10.0
	
	GlobalUtilities.screen_shake(shake*screen_shake_modifier)
	
	if is_dead():
		# micro pause the game based on how much hp the dead guy had
		get_tree().paused = true
		get_tree().create_timer(0.05*stats.get_max("HP"), true)
		get_tree().paused = false

		_on_death()
		emit_signal("died")
	else:
		_on_damage_taken(damage)
		emit_signal("taken_damage")
	
func is_dead():
	return stats.get_current("HP") <=0