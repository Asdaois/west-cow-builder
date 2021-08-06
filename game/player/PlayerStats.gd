# class_name
extends Node

# custom signals
signal no_nuggets
signal nuggets_changed(value)
signal max_nuggets_changed(value)
# enums - constant

# exports variables
export var max_nuggets = 10 setget set_max_nuggets
export var nuggets = 0 setget set_nuggets

# public - private variables

# on ready variables

# built-in functions
func _ready():
	self.nuggets = max_nuggets

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

# signals handlers
