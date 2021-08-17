extends Resource
class_name NpcWeapons

# custom signals
signal name_changed(value)
signal damage_changed(value)

# exports variables
export var weapon_name = "Shitty Gun" setget set_weapon_name
export var weapon_damage = 1 setget set_weapon_damage

# public - private functions
func set_weapon_name(value):
	weapon_name = value
	emit_signal("name_changed", value)

func set_weapon_damage(value):
	weapon_damage = value
	emit_signal("damage_changed", value)
