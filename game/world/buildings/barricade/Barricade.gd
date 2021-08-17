# class_name
extends StaticBody2D

# custom signals

# enums - constant

# exports variables
export var BUILDING_TIME = 10
export var BUILDING_COST = 1
export(Resource) var nuggets = nuggets as ItemResource

# public - private variables
var _buildable = false
var _building = false
var _built = false

# on ready variables
onready var label = $Label
onready var start_building = $StartBulding
onready var building_time = $BuildingTime
onready var sprite = $Sprite

# built-in functions

func _process(_delta):
	if start_building.time_left > 0:
		label.text = "Start building in: " + str(int(start_building.time_left)) + "s"
	if building_time.time_left > 0:
		label.text = "Building... " + str(int(building_time.time_left)) + "s left"

func _input(event):
	if(_buildable):
		if event.is_action_pressed("ui_down"):
			_start_input_timer(3)
		if event.is_action_released("ui_down"):
			_stop_input_timer()

# public - private functions
func _start_input_timer(duration):
	start_building.start(duration)

func _stop_input_timer():
	start_building.stop()
	label.text = "Presiona v para\nconstruir una\nbarricada"

# signals handlers
func _on_Area2D_body_entered(body):
	if body.is_in_group("player") and _built == false:
		if nuggets.quantity > 1:
			label.text = "Presiona v para\nconstruir una\nbarricada"
			_buildable = true
		else:
			label.text = "No tienes oro \nsuficiente"
			_buildable = false

func _on_Area2D_body_exited(body: Node):
	if body.is_in_group("player") and _built == false:
		label.text = ""
		_buildable = false

func _on_StartBulding_timeout():
	label.text = ""
	_building = true
	nuggets.quantity -= BUILDING_COST
	building_time.start(BUILDING_TIME)

func _on_BuildingTime_timeout():
	_built = true
	_building = false
	_buildable = false
	sprite.frame = 1
	self.set_collision_layer_bit(6, true)
	label.text = ""
