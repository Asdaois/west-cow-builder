class_name Player
extends KinematicBody2D

# custom signals

# enums - constant

# exports variables
export var ACCELERATION = 100
export var MAX_SPEED = 400
export var FRICTION = 200
export var GRAVITY = 400
# public - private variables
var velocity := Vector2.ZERO
var stats = PlayerStats

# on ready variables
onready var animationPlayer := $AnimationPlayer
onready var label := $Label

# built-in functions
func _ready() -> void:
	stats.connect("nuggets_changed", self, "_get_nugget")

func _physics_process(delta) -> void:
	_move_state(delta)
	
# public - private functions
func receive_damage(damage: int) -> void:
	stats.nuggets -= damage


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

func _get_nugget(value):
	label.text = String(value)

# signals handlers
