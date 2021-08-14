class_name Player
extends KinematicBody2D

# custom signals

# enums - constant
enum {
	WALK,
	RUN,
	TIRED
}

# exports variables
export var MAX_SPEED = 400
export var FRICTION = 400
export var GRAVITY = 4000
export var WATER_CONSUMPTION_TIME = 1
export var WATER_CONSUMPTION_QUANTITY = 6

export(Resource) var cows = cows as ItemResource
export(Resource) var nuggets = nuggets as ItemResource
export(Resource) var water = water as ItemResource
export(PackedScene) var nugget_scene
export(NodePath) onready var player_area = get_node(player_area) as Area2D

# public - private variables
var NORMAL_SPEED = MAX_SPEED / 2
var RUNNING_SPEED = MAX_SPEED
var TIRED_SPEED = MAX_SPEED / 4
var WATER_NORMAL = WATER_CONSUMPTION_QUANTITY
var WATER_RUNNING = WATER_CONSUMPTION_QUANTITY * 3
var velocity := Vector2.ZERO
var state

var current_target : Node setget _set_current_target

func _set_current_target(new_value : Node):
	if new_value == null:
		current_target = null
		return
		
	if current_target == null:
		current_target = new_value
		return
	
	if current_target.is_in_group("broken_cart"):
		return
	
	if new_value.is_in_group("broken_cart"):
		if current_target.is_in_group("cow"):
			(current_target)._disable_picking()
		current_target = new_value


	current_target = new_value


# on ready variables
onready var animationPlayer := $AnimationPlayer
onready var label := $Label
onready var label2 := $Label2
onready var label3 := $Label3
onready var running_timer := $RunningTimer

# built-in functions
func _ready() -> void:
	assert(nuggets.connect("quantity_changed", self, "_get_nugget") == 0)
	assert(nuggets.connect('quantity_emptied', self, "_game_over") == 0)
	assert(cows.connect("quantity_changed", self, "_get_cow") == 0)
	assert(water.connect("quantity_changed", self, "_get_water") == 0)

func _physics_process(delta) -> void:
	_move_state(delta)
	if(velocity.x != 0):
		match state:
			WALK:
				water.quantity -= stepify(WATER_NORMAL * delta, 0.01)
			RUN:
				water.quantity -= stepify(WATER_RUNNING * delta, 0.01)

func _input(event):
	if event.is_action_pressed("drop_nugget"):
		if nuggets.quantity == 1:
			print_debug("One GOLD to the poor")
		elif nuggets.quantity > 0:
			nuggets.quantity -= 1
			_instantiate_nugget()
	
	if event.is_action_pressed("ui_left") or event.is_action_pressed("ui_right"):
		if state != TIRED:
			state = WALK
			if(event.is_echo() != true and running_timer.time_left > 0):
				state = RUN
			running_timer.start(0.5)

func _process(_delta):
	if(water.quantity == 0):
		state = TIRED

# public - private functions
func receive_damage(damage: int) -> void:
	nuggets.quantity -= damage
	_instantiate_nugget()

func _instantiate_nugget():
	GameSignals.emit_signal("instanciate_item_in_world", nugget_scene, global_position)
	
func _move_state(delta) -> void:
	var input_vector := Vector2.ZERO
	input_vector.x = (
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	)
	
	if input_vector != Vector2.ZERO:
		if input_vector.x < 0:
			animationPlayer.play("WalkLeft")
		else:
			animationPlayer.play("WalkRight")
		match state:
			WALK:
				velocity = input_vector * NORMAL_SPEED
			RUN:
				velocity = input_vector * RUNNING_SPEED
			TIRED:
				velocity = input_vector * TIRED_SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	_add_gravity(delta)
	_move()

func _add_gravity(delta) -> void:
	if !is_on_floor():
		velocity.y += delta * GRAVITY

func _move() -> void:
	velocity = move_and_slide(velocity)

func _get_nugget(value):
	label.text = "Nuggets: " + String(value)

func _get_cow(value):
	label2.text = "Cows: " + String(value)

func _get_water(value):
	label3.text = "Water: " + String(value)

func _game_over():
	GameStateManager.game_over()
	queue_free()

# signals handlers
