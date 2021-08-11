# class_name
extends KinematicBody2D

# custom signals

# enums - constant
enum {
	IDLE,
	WANDER
}

# exports variables
export var GRAVITY = 400
export var PICKUP_TIME = 3
export var ACCELERATION = 300
export var MAX_SPEED = 50
export var FRICTION = 200 
export(Resource) var cow = cow as ItemResource
# public - private variables
var _pickable = false
var _update_timer = false
var _state
var velocity := Vector2.ZERO

# on ready variables
onready var label := $Label
onready var pickup_timer := $PickupTimer
onready var wander_controller := $WanderController
onready var sprite := $Sprite

# built-in functions

func _ready():
	randomize()
	_state = _pick_random_state([IDLE, WANDER])

func _process(delta):
	if(_update_timer):
		label.text = "Recogiendo: " + str(int(pickup_timer.time_left)) + "s"

func _input(event) -> void:
	if(_pickable):
		if event.is_action_pressed("ui_down"):
			_state = IDLE
			_timer_start()
		if event.is_action_released("ui_down"):
			_timer_stop()
	else:
		_timer_stop()

func _physics_process(delta):
	match _state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			if wander_controller.get_time_left() == 0:
				_update_wander()
		WANDER:
			_accelerate_towards_point(wander_controller.target_position, delta)
			if global_position.distance_to(wander_controller.target_position) <= 4:
				_update_wander()
			if wander_controller.get_time_left() == 0:
				_update_wander()
	_add_gravity(delta)
	velocity = move_and_slide(velocity)

# public - private functions
func _add_gravity(delta) -> void:
	if !is_on_floor():
		velocity.y += delta * GRAVITY

func _timer_start():
	pickup_timer.start(PICKUP_TIME)
	_update_timer = true

func _timer_stop():
	pickup_timer.stop()
	_update_timer = false
	if(_pickable):
		label.text = "presiona v para \nrecoger la vaca"
	else:
		label.text = ""

func _update_wander():
	_state = _pick_random_state([IDLE, WANDER])
	wander_controller.start_wander_timer(rand_range(2, 4))

func _pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _accelerate_towards_point(point, delta): 
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

# signals handlers
func _on_PickupTimer_timeout():
	(cow as ItemResource).quantity += 1
	queue_free()

func _on_PlayerDetectionArea_body_entered(body: Node) -> void:
	if body is Player:
		label.text = "presiona v para \nrecoger la vaca"
		_pickable = true

func _on_PlayerDetectionArea_body_exited(body):
	label.text = ""
	_pickable = false
