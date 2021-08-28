extends KinematicBody2D
class_name Enemy

export(float, 0, 200) var run_speed :float = 450
export(float, 150, 450) var gravity := 300
export(float, 0, 200) var range_distance : float = 150
export(int) var life := 10

var velocity := Vector2.ZERO
var target : PhysicsBody2D

export(NodePath) onready var attack_cooldown_timer = get_node(attack_cooldown_timer) as Timer
export(NodePath) onready var state_machine = get_node(state_machine) as StateMachine 

func _ready() -> void:
	# Ininitialize statemachine
	var _c = GameStateManager.connect('game_over', self, "_on_player_died")
	for state in state_machine.get_children():
		if "enemy" in state:
			state["enemy"] = self


func _process(_delta: float) -> void:
	_get_better_speed()


func _physics_process(delta: float) -> void:
	_add_gravity(delta)
	_move()


func _add_gravity(delta : float) -> void:
	if !is_on_floor():
		velocity.y += delta * gravity


func _move():
	velocity = move_and_slide(velocity, Vector2.UP)


func _get_target_direction() -> void:
	if not is_instance_valid(target):
		return
	velocity.x = 0
	if position.direction_to(target.position).x > 0:
		velocity.x = 1
	elif position.direction_to(target.position).x < 0:
		velocity.x = -1


func _get_better_speed() -> void:
	if target == null:
		return
	# This formula is better A^2 = B^2 + C^2 that A = (B^2 + C^2)^1/2
	var distance_to_player = position.distance_squared_to(target.position)
	var distance_to_accelerate = pow(range_distance, 2)
	if(distance_to_accelerate > distance_to_player):
		velocity.x *= 1.5
		return
