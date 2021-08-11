extends KinematicBody2D
class_name Enemy

# custom signals

# enums - constant
enum EnemyState {
	FOLLOW_PLAYER,
	SEARCH_GOLD,
	WANDER,
	COOLDOW_ATTACK
}
# exports variables
export(float, 0, 200) var run_speed := 25
export(float, 150, 450) var gravity := 300
export(float, 1, 2) var recoy_in_x : float = 1.5
export(float, 0, 120) var recoy_in_y : float  = 60
export(float, 0, 200) var rage_distance : float = 150
export(float) var time_between_attacks : int = 1.5
export(EnemyState) var _current_state = EnemyState.WANDER

# public - private variables
var velocity := Vector2.ZERO
var target : PhysicsBody2D
var _is_player_in_range := false
var _direction_options := [Vector2.RIGHT, Vector2.LEFT]

# on ready variables
export(NodePath) onready var wander_timer = get_node(wander_timer) as Timer
export(NodePath) onready var attack_cooldown_timer = get_node(attack_cooldown_timer) as Timer
# built-in functions

func _ready() -> void:
	GameStateManager.connect('game_over', self, "_on_player_died")


func _physics_process(delta: float) -> void:
	_add_gravity(delta)
	_do_action(delta)
	_move()

# public - private functions

func _do_action(delta) -> void:
	match _current_state:
		EnemyState.FOLLOW_PLAYER:
			if target == null:
				return
			_get_target_direction()
			_attack_player()
		EnemyState.COOLDOW_ATTACK:
			yield(attack_cooldown_timer, "timeout")
			_resume_follow_player()
		EnemyState.SEARCH_GOLD:
			_get_target_direction()
		EnemyState.WANDER:
			pass


func _change_state(new_state) -> void:
	_current_state = new_state


func _resume_follow_player() -> void:
	velocity.x = 0 # Stop the movement in x
	yield(get_tree().create_timer(0.5), 'timeout')
	_change_state(EnemyState.FOLLOW_PLAYER)


func _add_gravity(delta : float) -> void:
	if !is_on_floor():
		velocity.y += delta * gravity


func _get_target_direction() -> void:
	if not target:
		return
	
	velocity.x = 0
	velocity = (position.direction_to(target.position) * _get_better_speed())
	velocity = velocity * Vector2.RIGHT


func _get_better_speed() -> float:
	if target == null:
		return float(0)
	# This formula is more quickli A^2 = B^2 + C^2 
	var distance_to_player = position.distance_squared_to(target.position)
	var distance_to_accelerate = pow(rage_distance, 2)
	if(distance_to_accelerate > distance_to_player):
		return run_speed * 1.5
	return (run_speed as float)


func _move():
	velocity = move_and_slide(velocity, Vector2.UP)


func _attack_player() -> void:
	if not target is Player:
		return
	
	if _is_player_in_range:
		target.receive_damage(1)
		_change_state(EnemyState.COOLDOW_ATTACK)
		attack_cooldown_timer.start()

func _calculate_bounce(direction: Vector2, multiplier = 1) -> Vector2:
	direction.normalized()
	return velocity.bounce(direction) * (rand_range(1, recoy_in_x) * multiplier)


func _on_player_died() -> void:
	_change_state(EnemyState.WANDER)
	target = null



func _on_AtackCooldownTimer_timeout() -> void:
	var overlaping_bodies = $DetectionRange.get_overlapping_bodies()
	for body in overlaping_bodies:
		if body is Player:
			print_debug("follow player")
			_change_state(EnemyState.FOLLOW_PLAYER)
			target = body


func _on_DetectionRange_body_entered(body: Node) -> void:
	if body is Nugget:
		_change_state(EnemyState.SEARCH_GOLD)
		target = body
	elif body is Player:
		_change_state(EnemyState.FOLLOW_PLAYER)
		target = body


func _on_AttackRange_body_entered(body: Node) -> void:
	if body is Player:
		target = body
		_is_player_in_range = true
		
	if body is Nugget:
		target = null
		body.queue_free()


func _on_AttackRange_body_exited(body: Node) -> void:
	if body is Player:
		_is_player_in_range = false


func _on_DetectionRange_body_exited(body: Node) -> void:
	if body is Nugget:
		velocity = Vector2.ZERO
		_change_state(EnemyState.WANDER)
		attack_cooldown_timer.start()
