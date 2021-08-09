# class_name
extends KinematicBody2D

# custom signals

# enums - constant

# exports variables
export(float, 0, 200) var run_speed := 25
export(float, 150, 450) var gravity := 300
export(float, 1, 2) var recoy_in_x : float = 1.5
export(float, 0, 120) var recoy_in_y : float  = 60
export(float, 0, 200) var rage_distance : float = 150
export(float) var time_between_attacks : int = 1.5
# public - private variables
var velocity := Vector2.ZERO
var player : Player
var _can_follow_player := true
var _can_attack_player := true
var _collision : KinematicCollision2D
var _is_player_overlapping := false
var _direction_options := [Vector2.RIGHT, Vector2.LEFT]
# on ready variables
onready var attackCooldownTimer := $AtackCooldownTimer
# built-in functions

func _ready() -> void:
	GameStateManager.connect('game_over', self, "_on_player_died")


func _process(delta: float) -> void:
	_get_player_direction()
	

func _physics_process(delta: float) -> void:
	_add_gravity(delta)
	if _can_follow_player:
		_move_and_collide(delta)
		if _is_collision_player() and _can_attack_player:
			_attack_player()
	else:
		_move()
		if is_on_floor():
			_resume_follow_player()


# public - private functions

func _resume_follow_player() -> void:
	velocity.x = 0 # Stop the movement in x
	yield(get_tree().create_timer(0.5), 'timeout')
	_can_follow_player = true


func _add_gravity(delta : float) -> void:
	if !is_on_floor():
		velocity.y += delta * gravity


func _get_player_direction() -> void:
	if player != null and _can_follow_player:
		velocity.x = 0
		velocity = (position.direction_to(player.position) * _get_better_speed())
		velocity = velocity * Vector2.RIGHT


func _get_better_speed() -> float:
	if player == null:
		return float(0)
	# This formula is more quickli A^2 = B^2 + C^2 
	var distance_to_player = position.distance_squared_to(player.position)
	var distance_to_accelerate = pow(rage_distance, 2)
	if(distance_to_accelerate > distance_to_player):
		return run_speed * 1.5
	return (run_speed as float)



func _move():
	velocity = move_and_slide(velocity, Vector2.UP)


func _move_and_collide(delta : float):
	_collision = move_and_collide(velocity * delta)


func _is_collision_player() -> bool:
	if _collision:
		if (_collision.collider as Node2D).is_in_group("player"):
			return true
	return false


func _attack_player() -> void:
	_disable_collision_with_player()
	player.receive_damage(1)
	_can_follow_player = false
	_can_attack_player = false
	attackCooldownTimer.start()
	_do_attack_move()


func _do_attack_move() -> void:
	velocity.y = -60 - rand_range(0, recoy_in_y)
	velocity.x += velocity.x / 4
	if not _is_player_overlapping:
		velocity = _calculate_bounce(_collision.normal)
	else:
		_direction_options.shuffle()
		velocity = _calculate_bounce(_direction_options[0], 2)
		velocity.y = -10

func _calculate_bounce(direction: Vector2, multiplier = 1) -> Vector2:
	 return velocity.bounce(direction) * (rand_range(1, recoy_in_x) * multiplier)

func _disable_collision_with_player() -> void:
	set_collision_mask_bit(0, false)
	pass

func _enable_collision_with_player() -> void:
	if _is_player_overlapping:
		return
	set_collision_mask_bit(0, true)
# signals handlers


func _on_DetectionRange_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player = body
	pass


func _on_AtackCooldownTimer_timeout() -> void:
	_can_attack_player = true
	_enable_collision_with_player()
	if _is_player_overlapping:
		_attack_player()


func _on_player_died() -> void:
	_can_attack_player = false
	_can_follow_player = false
	player = null


func _on_PlayerInAttackRange_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		_is_player_overlapping = true


func _on_PlayerInAttackRange_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		_is_player_overlapping = false
		_enable_collision_with_player()
