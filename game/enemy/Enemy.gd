# class_name
extends KinematicBody2D

# custom signals

# enums - constant

# exports variables
export var run_speed := 25
export var gravity := 200
# public - private variables
var velocity := Vector2.ZERO
var player : Node2D
# on ready variables

# built-in functions

func _init() -> void:
	pass


func _ready() -> void:
	print("The initial value of velocity is {0}".format(velocity))
	pass

func _process(delta: float) -> void:
	#print_debug(velocity)
	pass

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	_follow_player()
	_add_gravity(delta)
	velocity = move_and_slide(velocity, Vector2.UP)
# public - private functions

func _add_gravity(delta) -> void:
	if !is_on_floor():
		velocity.y += delta * gravity
	
func _follow_player() -> void:
	if player != null:

		velocity = (position.direction_to(player.position) * run_speed)
		velocity = velocity * Vector2.RIGHT
		
	pass

# signals handlers

func _on_DetectionRange_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		print_debug("Found player")
		player = body
	pass


func _on_DetectionRange_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		print_debug("Bye player")
		player = null
		pass
