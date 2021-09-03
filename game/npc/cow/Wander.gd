# class_name
extends Node

signal update_wander

export(NodePath) onready var wander_timer = get_node(wander_timer) as Timer
export(NodePath) onready var wander_controller = get_node(wander_controller) as Node2D

var state_machine: StateMachine
var cow: Cow

func enter():
	print("im wandering lmao")
	#do_wander()

func exit(next_state):
	print("im exiting wandering lmao")
	state_machine.change_to(next_state)

func physics_process(delta):
	cow._accelerate_towards_point(wander_controller.target_position, delta)
	if cow.global_position.distance_to(wander_controller.target_position) <= 4:
		exit("Idle")
	if wander_controller.get_time_left() == 0:
		exit("Idle")
