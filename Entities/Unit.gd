extends Node2D


onready var gui = get_tree().current_scene.get_node("GUI")
onready var stats = get_node("StatBlock")
onready var area_component = get_node("AreaComponent")

export var screen_shake_modifier = 1.0
export(String) var resistance = ""
export(String) var weakness = ""

var unit_name = "Sabrino"

signal died
signal taken_damage(danage)
signal taken_crit(damage)

func _ready():
	unit_name = name.split("@", false)[0]
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
	assert stats.has_stat("Luck")
	
	var shake = 0
	var luck_coeficient = damage.source.stats.get_current("Luck") - (self.stats.get_current("Luck") *0.5)
	luck_coeficient = luck_coeficient / 15.0
	var is_crit = rand() < luck_coeficient
	# Areas cant recive crits
	is_crit = false if self.is_in_group("Areas") else is_crit
	
	for weak_to in weakness.split(",", false):
		if tags.has(weak_to):
			damage.amount = damage.amount *2
			break
	for resist in resistance.split(",", false):
		if tags.has(resist):
			damage.amount = damage.amount /2
			break
	
	if is_crit:
		damage.amount = damage.amount * 3
	
	if stats.has_stat("Shield") and stats.get_current("Shield") > 0:
		# Shields halves energy damage
		# Soaks the damage instead of the HP
		var dmg = ceil(damage.amount/2) if damage.tags.has("energy") else damage.amount
		stats.add_to_current("Shield", -dmg)
		shake = dmg /20.0
	elif stats.has_stat("Armor") and stats.get_current("Armor") >0:
		# Armor reduces damage to a min of 1
		var dmg = damage.amount
		if damage.tags.has("energy"):
			max(1, damage.amount - stats.get_current("Armor")) 
		stats.add_to_current("HP", -dmg)
		shake = dmg /10.0
	else:
		# just take it
		var dmg = damage.amount
		stats.add_to_current("HP", -dmg)
		shake = dmg /10.0
	var ssmod = screen_shake_modifier * (10 if is_crit else 0 )
	GlobalUtilities.screen_shake(shake*ssmod)
	
	if is_dead():
		# micro pause the game based on how much hp the dead guy had
		get_tree().paused = true
		get_tree().create_timer(0.05*stats.get_max("HP"), true)
		get_tree().paused = false

		_on_death()
		emit_signal("died")
	else:
		_on_damage_taken(damage)
		emit_signal("taken_damage", damage)
		if is_crit:
			emit_signal("taken_crit", damage)
	
func is_dead():
	return stats.get_current("HP") <=0