# class_name
extends RigidBody2D

# custom signals

# enums - constant

# exports variables

# public - private variables
var stats = PlayerStats

# on ready variables

# built-in functions

# public - private functions

# signals handlers

func _on_Area2D_area_entered(area):
	stats.nuggets += 1
	print(stats.nuggets)
	queue_free()
