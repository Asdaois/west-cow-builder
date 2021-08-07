# class_name
extends StaticBody2D

# custom signals

# enums - constant

# exports variables
export var NUGGETS_EARNED = 3

# public - private variables
var _delivery = false
var stats = PlayerStats

# on ready variables
onready var label := $Label

# built-in functions

func _init() -> void:
	pass

func _input(event):
	if(_delivery):
		if(Input.get_action_strength("ui_down")):
			stats.nuggets += NUGGETS_EARNED * stats.cows
			stats.cows = 0

func _ready() -> void:
	pass

# public - private functions


# signals handlers


func _on_DetectionArea_area_entered(area):
	if area.name == "PlayerArea":
		if(stats.cows > 0):
			label.text = "Entregar Vacas"
			_delivery = true
		else:
			label.text = "No tienes vacas"


func _on_DetectionArea_area_exited(area):
	label.text = ""
	_delivery = false
