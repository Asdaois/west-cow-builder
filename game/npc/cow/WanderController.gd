# class_name
extends Node2D

# custom signals

# enums - constant

# exports variables
export(int) var wander_range = 16

# public - private variables

# on ready variables
onready var start_position = global_position
onready var target_position = global_position
onready var timer: Timer = $Timer

# built-in functions
func _ready():
  _update_target_position()

# public - private functions
func _update_target_position():
  var target_vector = Vector2(rand_range(-wander_range, wander_range), 0)
  target_position = start_position + target_vector

func get_time_left():
  return timer.time_left

func start_wander_timer(duration):
  timer.start(duration)

# signals handlers
func _on_Timer_timeout():
  _update_target_position()
