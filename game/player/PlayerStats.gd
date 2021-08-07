class_name Stats
extends Node

# custom signals
signal no_nuggets
signal no_water
signal nuggets_changed(value)
signal max_nuggets_changed(value)
signal cows_changed(value)
signal max_cows_changed(vale)
signal water_changed(value)
signal max_water_changed(value)
# enums - constant

# exports variables
export var max_nuggets := 10 setget set_max_nuggets
export var nuggets := 0 setget set_nuggets
export var max_cows := 1 setget set_max_cows
export var cows := 0 setget set_cows
export var max_water := 100 setget set_max_water
export var water := 100 setget set_water

# public - private variables

# on ready variables

# built-in functions
func _ready():
	self.nuggets = 0
	self.cows = 0
	self.water = 100

# public - private functions
func set_max_nuggets(value):
	max_nuggets = value
	self.nuggets = min(nuggets, max_nuggets)
	emit_signal("max_nuggets_changed", max_nuggets)
	
func set_nuggets(value):
	nuggets = value
	emit_signal("nuggets_changed", nuggets)
	if(nuggets <= 0):
		emit_signal("no_nuggets")

func set_max_cows(value):
	max_cows = value
	self.cows = min(cows, max_cows)
	emit_signal("max_cows_changed", max_cows)

func set_cows(value):
	cows = value
	emit_signal("cows_changed", cows)

func set_max_water(value):
	max_water = value
	self.water = min(water, max_water)
	emit_signal("max_water_changed", max_water)

func set_water(value):
	water = value
	emit_signal("water_changed", water)
	if(water <= 0):
		emit_signal("no_water")

# signals handlers
