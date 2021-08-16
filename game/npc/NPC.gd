extends KinematicBody2D
class_name NPC

signal work_changed

export(float) var speed := 40.0
export(NodePath) onready var wander_timer = get_node(wander_timer) as Timer
export(Enums.NPC_WORKS) var current_work setget change_work

func change_work(new_value):
	current_work = new_value
	emit_signal("work_changed")

var velocity := Vector2.ZERO
var nugget: Node
var nugget_picked: Node
var broken_cart: Node
var is_outside_wander_area: bool

func _ready() -> void:
	for state in get_tree().get_nodes_in_group("state_machine"):
		if is_a_parent_of(state):
			if "npc" in state:
				state.npc = self
	$StateMachine.start_machine()


func _physics_process(_delta: float) -> void:
	_add_gravity()
	velocity = move_and_slide(velocity, Vector2.UP)


func _add_gravity():
	velocity.y += 10

func _on_NuggetDetector_body_entered(body: Node) -> void:
	nugget = body


func _on_NuggetDetector_body_exited(_body: Node) -> void:
	nugget = null

func _get_target_direction(target) -> void:
	if not is_instance_valid(target):
		return
	velocity.x = 0
	if global_position.direction_to(target.global_position).x >= 0:
		velocity.x = 1
	elif global_position.direction_to(target.global_position).x < 0:
		velocity.x = -1


func _on_NuggetPicker_body_entered(body: Node) -> void:
	nugget_picked = body

func wait_for_new_state() -> void:
	velocity = Vector2.ZERO

func _on_WanderArea_exited(_area: Area2D) -> void:
	is_outside_wander_area = true

func apply_speed(factor: float) -> void:
	velocity.x = velocity.x * factor * speed

func _brokencart_area_entered(_area: Area2D) -> void:
	is_outside_wander_area = false


