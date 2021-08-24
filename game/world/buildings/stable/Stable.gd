# class_name
extends StaticBody2D

# custom signals

# enums - constant

# exports variables

# public - private variables
var _open_menu = false

# on ready variables

# built-in functions

# public - private functions


# signals handlers
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		print("Menu can be opened")
		_open_menu = true


func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		print("Menu cannot be opened")
		_open_menu = false
