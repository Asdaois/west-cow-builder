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
export(float, 0, 200) var run_speed :float = 450
export(float, 0, 100) var wander_speed := 40
export(float, 1, 4) var wander_time := 2
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
	# Ininitialize statemachine
	_change_state(_current_state)
	assert(GameStateManager.connect('game_over', self, "_on_player_died") == 0)


func _process(_delta: float) -> void:
	_do_action()
	pass

func _physics_process(delta: float) -> void:
	_add_gravity(delta)
	_move()

# public - private functions

func _add_gravity(delta : float) -> void:
	if !is_on_floor():
		velocity.y += delta * gravity


func _move():
	velocity = move_and_slide(velocity, Vector2.UP)


func _change_state(new_state) -> void:
	_current_state = new_state
	match new_state:
		EnemyState.WANDER:
			wander_timer.start()


func _do_action() -> void:
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
			if abs(global_position.x - target.global_position.x) < 2:
				velocity.x = 0
		EnemyState.WANDER:
			_do_wander()

func _get_target_direction() -> void:
	if not is_instance_valid(target):
		return
		
	velocity.x = 0

	if position.direction_to(target.position).x > 0:
		velocity.x = 1
	elif position.direction_to(target.position).x < 0:
		velocity.x = -1
	velocity.x *=  _get_better_speed()


func _attack_player() -> void:
	if not target is Player:
		return
	
	if _is_player_in_range:
		target.receive_damage(1)
		_change_state(EnemyState.COOLDOW_ATTACK)
		attack_cooldown_timer.start()


func _resume_follow_player() -> void:
	velocity.x = 0 # Stop the movement in x
	yield(get_tree().create_timer(0.5), 'timeout')
	_change_state(EnemyState.FOLLOW_PLAYER)


func _get_better_speed() -> float:
	if target == null:
		return float(0)
	# This formula is better A^2 = B^2 + C^2 that A = (B^2 + C^2)^1/2
	var distance_to_player = position.distance_squared_to(target.position)
	var distance_to_accelerate = pow(rage_distance, 2)
	if(distance_to_accelerate > distance_to_player):
		return run_speed * 1.5
	return run_speed

func _do_wander():
	yield(wander_timer, "timeout")
	velocity.x = 0
	yield(get_tree().create_timer(0.3),"timeout")
	wander_timer.start()
	wander_timer.wait_time = rand_range(1, wander_time)
	var random_direction = [Vector2.RIGHT, Vector2.LEFT]
	random_direction.shuffle()
	velocity.x = random_direction[0].x * wander_speed


func _check_overlapping_boddies() -> void:
	var overlaping_bodies = $DetectionRange.get_overlapping_bodies()
	for body in overlaping_bodies:
		if _current_state == EnemyState.WANDER:
			
			if body is Nugget:
				_change_state(EnemyState.SEARCH_GOLD)
				target = body
			
			if body is Player:
				if Globals.DEBUG:
					print_debug("follow player")
				_change_state(EnemyState.FOLLOW_PLAYER)
				target = body


func _on_player_died() -> void:
	_change_state(EnemyState.WANDER)
	target = null


func _on_AtackCooldownTimer_timeout() -> void:
	_check_overlapping_boddies()


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


func _on_WanderTimer_timeout() -> void:
	_check_overlapping_boddies()
