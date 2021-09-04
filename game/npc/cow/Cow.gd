extends KinematicBody2D
class_name Cow

enum {
	WANDER,
	IDLE
}

export var GRAVITY = 4000
export var PICKUP_TIME = 3
export var ACCELERATION = 300
export var MAX_SPEED = 400
export var FRICTION = 200 
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
	for state in $StateMachine.get_children():
		state.cow = self
	assert(GameSignals.connect("cow_is_picked",self, "_check_is_picked") == 0)


func _process(_delta):
	if(_update_timer):
		label.text = "Recogiendo: " + str(int(pickup_timer.time_left)) + "s"


func _input(event) -> void:
	if(_pickable):
		if event.is_action_pressed("ui_down"):
			_timer_start()
		if event.is_action_released("ui_down"):
			_timer_stop()
	else:
		_timer_stop()

func _physics_process(delta):
	_add_gravity(delta)
	velocity = move_and_slide(velocity)

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

func _accelerate_towards_point(point, delta): 
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
	sprite.flip_h = velocity.x < 0

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
