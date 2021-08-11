# class_name
extends Node2D

# custom signals

# enums - constant

# exports variables

# public - private variables

# on ready variables

# built-in functions

func _init() -> void:
  pass


func _ready() -> void:
  pass

# public - private functions


# signals handlers


func _on_Player_drop_nugget(nugget, direction, location):
	var n = nugget.instance()
	add_child(n)
	n.rotation = direction
	n.position = location
