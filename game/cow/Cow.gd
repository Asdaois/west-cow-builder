# class_name
extends KinematicBody2D

# custom signals

# enums - constant

# exports variables

# public - private variables
var _pickable = false

# on ready variables
onready var label := $Label

# built-in functions

func _init() -> void:
	pass

func _input(event):
	if(_pickable):
		if Input.is_key_pressed(16777234):
			print("brother")

func _ready() -> void:
	pass

# public - private functions

# signals handlers


func _on_PlayerDetectionArea_area_entered(area):
	if area.name == "PlayerArea":
		label.text = "presiona v para \nrecoger la vaca"
		_pickable = true

func _on_PlayerDetectionArea_area_exited(area):
	label.text = ""
	_pickable = false
