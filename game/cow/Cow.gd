# class_name
extends KinematicBody2D

# custom signals

# enums - constant

# exports variables
export var GRAVITY = 400
export var PICKUP_TIME = 3
export(Resource) var cow
# public - private variables
var _pickable = false
var _update_timer = false
var velocity := Vector2.ZERO

# on ready variables
onready var label := $Label
onready var pickup_timer := $PickupTimer

# built-in functions

func _init() -> void:
	pass
	
func _process(delta):
	if(_update_timer):
		label.text = "Recogiendo: " + str(int(pickup_timer.time_left)) + "s"

func _input(event) -> void:
	if(_pickable):
		if event.is_action_pressed("ui_down"):
			_timer_start()
		if event.is_action_released("ui_down"):
			_timer_stop()
	else:
		_timer_stop()

func _physics_process(delta):
	_add_gravity(delta)
	velocity = move_and_slide(velocity)

# public - private functions
func _add_gravity(delta) -> void:
	if !is_on_floor():
		velocity.y += delta * GRAVITY

func _timer_start():
	pickup_timer.start(PICKUP_TIME)
	_update_timer = true

func _timer_stop():
	pickup_timer.stop()
	_update_timer = false
	if(_pickable):
		label.text = "presiona v para \nrecoger la vaca"

# signals handlers

func _on_PlayerDetectionArea_area_entered(_area):
	if _area.name == "PlayerArea":
		label.text = "presiona v para \nrecoger la vaca"
		_pickable = true

func _on_PlayerDetectionArea_area_exited(area):
	label.text = ""
	_pickable = false

func _on_PickupTimer_timeout():
	(cow as ItemResource).quantity += 1
	queue_free()
