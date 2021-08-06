# class_name
extends KinematicBody2D

# custom signals

# enums - constant

# exports variables
export var run_speed := 25

# public - private variables
var velocity := Vector2.ZERO
var player : Node2D
# on ready variables

# built-in functions

func _init() -> void:
	pass


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if player:
		velocity = (position.direction_to(player.position) * run_speed)
		velocity = velocity * Vector2.RIGHT # Eliminate the AXIS Y
	velocity = move_and_slide(velocity)
	pass
# public - private functions


# signals handlers

func _on_DetectionRange_body_entered(body: Node) -> void:
	print_debug("Found player")
	player = body
	pass # Replace with function body.


func _on_DetectionRange_body_exited(body: Node) -> void:
	print_debug("Bye player")
	player = null
	pass # Replace with function body.
