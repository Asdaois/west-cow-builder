# class_name
extends Node

export(NodePath) onready var idle_timer = get_node(idle_timer) as Timer

var state_machine: StateMachine
var cow: Cow

func enter():
	print("im enteing enter")
	subscribe()
	do_idle()

func exit(next_state):
	print("im exiting idleing")
	unsubscribe()
	state_machine.change_to(next_state)

func subscribe():
	idle_timer.connect("timeout", self, "exit_wander")

func unsubscribe():
	idle_timer.disconnect("timeout", self, "exit_wander")

func do_idle():
	idle_timer.start(3)
	cow.velocity = cow.velocity.move_toward(Vector2.ZERO, cow.FRICTION * 1)

func exit_wander():
	exit("Wander")
