# class_name
extends RigidBody2D

# custom signals

# enums - constant

# exports variables
export(Resource) var nugget

# public - private variables

# on ready variables

# built-in functions

# public - private functions

# signals handlers

func _on_Area2D_area_entered(area):
	nugget.quantity += 1
	queue_free()
