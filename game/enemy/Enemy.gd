# class_name
extends KinematicBody2D

# custom signals

# enums - constant

# exports variables
export var run_speed := 25
export var gravity := 300
# public - private variables
var velocity := Vector2.ZERO
var player : Player
var can_follow_player := true
var collision : KinematicCollision2D
# on ready variables

# built-in functions

func _ready() -> void:
	print("The initial value of velocity is {0}".format(velocity))
	pass


func _physics_process(delta: float) -> void:
	_add_gravity(delta)
	if can_follow_player:
		_get_player_direction()
		_move_and_collide(delta)
		if _is_collision_player():
			_attack_player()
	else:
		_move()
		if is_on_floor():
			_resume_follow_player()


# public - private functions

func _resume_follow_player() -> void:
	velocity.x = 0 # Stop the movement in x
	yield(get_tree().create_timer(0.5), 'timeout')
	can_follow_player = true


func _add_gravity(delta : float) -> void:
	if !is_on_floor():
		velocity.y += delta * gravity


func _get_player_direction() -> void:
	velocity.x = 0
	if player != null:
		velocity = (position.direction_to(player.position) * run_speed)
		velocity = velocity * Vector2.RIGHT


func _move():
	velocity = move_and_slide(velocity, Vector2.UP)

func _move_and_collide(delta : float):
	collision = move_and_collide(velocity * delta)

func _is_collision_player() -> bool:
	if collision:
		if (collision.collider as Node2D).is_in_group("player"):
			return true
	return false


# signals handlers
func _attack_player():
	velocity.y = -60 - rand_range(0, 60)
	velocity.x += velocity.x / 4
	velocity = velocity.bounce(collision.normal) * rand_range(1, 1.5)
	can_follow_player = false
	# TODO: Do damage to player? 
	# variable player
	
func _on_DetectionRange_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player = body
	pass
