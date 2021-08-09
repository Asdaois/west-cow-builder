# class_name
extends Node2D

# custom signals

# enums - constant

# exports variables
export (Resource) var Nuggets
# public - private variables
onready var nuggets : ItemResource = Nuggets
# on ready variables
onready var player := $Player
# built-in functions

func _init() -> void:
	pass


func _ready() -> void:
	nuggets.quantity += 1
	pass

# public - private functions


# signals handlers
