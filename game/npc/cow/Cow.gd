extends KinematicBody2D
class_name Cow

enum {
<<<<<<< HEAD
  IDLE,
  WANDER
=======
	WANDER,
	IDLE
>>>>>>> cow-state-test
}

export var GRAVITY = 4000
export var PICKUP_TIME = 3
export var ACCELERATION = 300
<<<<<<< HEAD
export var MAX_SPEED = 50
export var FRICTION = 200
=======
export var MAX_SPEED = 400
export var FRICTION = 200 
>>>>>>> cow-state-test
export(Resource) var cow = cow as ItemResource


var _pickable = false
var _update_timer = false
var _state
var velocity := Vector2.ZERO

# on ready variables
onready var label := $Label
onready var pickup_timer := $Timers/PickupTimer
onready var wander_controller := $WanderController
onready var sprite := $Sprite

# built-in functions

func _ready():
<<<<<<< HEAD
  randomize()
  _state = _pick_random_state([IDLE, WANDER])
  assert(GameSignals.connect("cow_is_picked",self, "_check_is_picked") == 0)
=======
	for state in $StateMachine.get_children():
		state.cow = self
	assert(GameSignals.connect("cow_is_picked",self, "_check_is_picked") == 0)
>>>>>>> cow-state-test


func _process(_delta):
  if(_update_timer):
    label.text = "Recogiendo: " + str(int(pickup_timer.time_left)) + "s"

func _input(event) -> void:
<<<<<<< HEAD
  if(_pickable):
    if event.is_action_pressed("ui_down"):
      _state = IDLE
      _timer_start()
    if event.is_action_released("ui_down"):
      _timer_stop()
  else:
    _timer_stop()
=======
	if(_pickable):
		if event.is_action_pressed("ui_down"):
			_timer_start()
		if event.is_action_released("ui_down"):
			_timer_stop()
	else:
		_timer_stop()
>>>>>>> cow-state-test

func _physics_process(delta):
<<<<<<< HEAD
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
=======
	_add_gravity(delta)
	velocity = move_and_slide(velocity)
>>>>>>> cow-state-test

# public - private functions
func _check_is_picked(body):
  if body != self:
    disable_picking()
  elif body == self:
    enable_picking()

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

<<<<<<< HEAD

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
=======
func _accelerate_towards_point(point, delta): 
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0
>>>>>>> cow-state-test

func disable_picking():
  label.text = ""
  _pickable = false

func enable_picking():
  label.text = "presiona v para \nrecoger la vaca"
  _pickable = true

func _on_PickupTimer_timeout():
  cow.quantity += 1
  GameSignals.emit_signal("cow_exited_player_range")
  queue_free()

func _on_PlayerDetectionArea_body_entered(body: Node) -> void:
  if body is Player:
    GameSignals.emit_signal("cow_exited_player_range")

func _on_PlayerDetectionArea_body_exited(body):
  if body is Player:
    GameSignals.emit_signal("cow_exited_player_range")
    disable_picking()
