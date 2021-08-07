# class_name
extends KinematicBody2D

# custom signals

# enums - constant

# exports variables
export var GRAVITY = 400

# public - private variables
var _pickable = false
var stats = PlayerStats
var velocity := Vector2.ZERO

# on ready variables
onready var label := $Label

# built-in functions

func _init() -> void:
	pass

func _input(_event) -> void:
	if(_pickable):
		if Input.is_key_pressed(16777234):
			stats.cows += 1
			print(stats.cows)
			queue_free()

func _physics_process(delta):
	_add_gravity(delta)

# public - private functions
func _add_gravity(delta) -> void:
	if !is_on_floor():
		velocity.y += delta * GRAVITY
	velocity = move_and_slide(velocity)

# signals handlers

func _on_PlayerDetectionArea_area_entered(_area):
	if _area.name == "PlayerArea":
		label.text = "presiona v para \nrecoger la vaca"
		_pickable = true

func _on_PlayerDetectionArea_area_exited(area):
	label.text = ""
	_pickable = false
