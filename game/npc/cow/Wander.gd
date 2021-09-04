# class_name
extends Node

export(NodePath) onready var wander_timer = get_node(wander_timer) as Timer
export(NodePath) onready var wander_controller = get_node(wander_controller) as Node2D

var state_machine: StateMachine
var cow: Cow

func enter():
	print("Moovign")
	wander_controller.start_wander_timer(rand_range(2, 4))

func exit(next_state):
	print("I'm not MOOving")
	state_machine.change_to(next_state)

func physics_process(delta):
	cow._accelerate_towards_point(wander_controller.target_position, delta)
	if cow.global_position.distance_to(wander_controller.target_position) <= 4:
		exit("Idle")
	if wander_controller.get_time_left() <= 0:
		exit("Idle")

func input(event):
	if cow._pickable:
		if event.is_action_pressed("ui_down"):
			exit("Picking")
