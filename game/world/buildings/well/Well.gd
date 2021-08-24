# class_name
extends StaticBody2D

# custom signals

# enums - constant

# exports variables
export(Resource) var water = water as ItemResource
export var WATER_DRINK_QUANTITY = 40
export var WATER_DRINK_TIME = 2

# public - private variables
var _drinkable = false

# on ready variables
onready var label = $Label
onready var timer = $Timer

# built-in functions
func _input(event):
	if _drinkable:
		if event.is_action_pressed("ui_down"):
			_drink_water()
		if event.is_action_released("ui_down"):
			print("ni-")

# public - private functions
func _drink_water():
	label.text = "Glup glup glup"
	timer.start(WATER_DRINK_TIME)

# signals handlers


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		label.text = "Presiona v para\nRecargar tu agua"
		_drinkable = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("player"):
		label.text = ""
		_drinkable = false


func _on_Timer_timeout():
	label.text = "Your thirst is quenched"
	water.quantity += WATER_DRINK_QUANTITY
