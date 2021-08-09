class_name Player
extends KinematicBody2D

# custom signals

# enums - constant

# exports variables
export var ACCELERATION = 100
export var MAX_SPEED = 400
export var FRICTION = 200
export var GRAVITY = 400
export var WATER_CONSUMPTION_TIME = 3
export var WATER_CONSUMPTION_QUANTITY = 4
export(Resource) var cows
export(Resource) var nuggets
export(Resource) var water
# public - private variables
var velocity := Vector2.ZERO
var timer_flag = true

# on ready variables
onready var animationPlayer := $AnimationPlayer
onready var label := $Label
onready var label2 := $Label2
onready var label3 := $Label3
onready var water_consumption := $WaterConsumption

# built-in functions
func _ready() -> void:
	(nuggets as ItemResource).connect("quantity_changed", self, "_get_nugget")
	(nuggets as ItemResource).connect('quantity_emptied', self, "_game_over")
	(cows as ItemResource).connect("quantity_changed", self, "_get_cow")
	(water as ItemResource).connect("quantity_changed", self, "_get_water")
	# TODO: Delete this for test
	(nuggets as ItemResource).quantity += 500

func _physics_process(delta) -> void:
	_move_state(delta)
	
# public - private functions
func receive_damage(damage: int) -> void:
	nuggets.quantity -= damage


func _move_state(delta) -> void:
	var input_vector := Vector2.ZERO
	input_vector.x = (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	)
	
	if input_vector != Vector2.ZERO:
		if input_vector.x < 0:
			animationPlayer.play("WalkLeft")
		else:
			animationPlayer.play("WalkRight")
		velocity = (
			velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	_add_gravity(delta)
	_move()

func _add_gravity(delta) -> void:
	if !is_on_floor():
		velocity.y += delta * GRAVITY

func _move() -> void:
	velocity = move_and_slide(velocity)
	if (timer_flag):
		_water_timer()

func _water_timer() -> void:
	if(velocity.x != 0):
		water_consumption.start(WATER_CONSUMPTION_TIME)
		timer_flag = false
	else:
		water_consumption.stop()

func _get_nugget(value):
	label.text = "Nuggets: " + String(value)

func _get_cow(value):
	label2.text = "Cows: " + String(value)

func _get_water(value):
	label3.text = "Water: " + String(value)

func _game_over():
	GameStateManager.game_over()
	queue_free()

# signals handlers
func _on_WaterConsumption_timeout():
	water.quantity -= WATER_CONSUMPTION_QUANTITY
	timer_flag = true
