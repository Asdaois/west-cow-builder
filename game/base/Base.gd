# class_name
extends StaticBody2D

# custom signals

# enums - constant

# exports variables
export var NUGGETS_EARNED = 3
export(Resource) var cows
export(Resource) var nuggets
# public - private variables
var _delivery = false

# on ready variables
onready var label := $Label

# built-in functions

func _init() -> void:
	pass

func _input(event):
	if(_delivery):
		if(Input.get_action_strength("ui_down")):
			nuggets.quantity += NUGGETS_EARNED * cows.quantity
			cows.quantity = 0

func _ready() -> void:
	pass

# public - private functions


# signals handlers


func _on_DetectionArea_area_entered(area):
	if area.name == "PlayerArea":
		if(cows.quantity > 0):
			label.text = "Entregar Vacas"
			_delivery = true
		else:
			label.text = "No tienes vacas"


func _on_DetectionArea_area_exited(area):
	label.text = ""
	_delivery = false
