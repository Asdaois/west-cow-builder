# class_name
extends KinematicBody2D

# custom signals

# enums - constant

# exports variables
export var ACCELERATION = 100
export var MAX_SPEED = 400
export var FRICTION = 200

# public - private variables
var velocity = Vector2.ZERO
var stats = PlayerStats

# on ready variables
onready var animationPlayer = $AnimationPlayer

# built-in functions
func _ready():
	stats.connect("no_nuggets", self, "queue_free")
	

func _physics_process(delta):
	_move_state(delta)
	
# public - private functions

func _move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	if input_vector != Vector2.ZERO:
		if input_vector.x < 0:
			animationPlayer.play("WalkLeft")
		else:
			animationPlayer.play("WalkRight")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	_move()

func _move():
	velocity = move_and_slide(velocity)

# signals handlers
