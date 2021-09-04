# class_name
extends Node

export(NodePath) onready var idle_timer = get_node(idle_timer) as Timer

var state_machine: StateMachine
var cow: Cow

func enter():
	subscribe()

func exit(next_state):
	unsubscribe()
	state_machine.change_to(next_state)

func subscribe():
	idle_timer.connect("timeout", self, "exit_wander")
	idle_timer.start(rand_range(2, 4))

func unsubscribe():
	idle_timer.disconnect("timeout", self, "exit_wander")

func process(delta):
	cow.velocity = cow.velocity.move_toward(Vector2.ZERO, cow.FRICTION * delta)

func input(event):
	if cow._pickable:
		if event.is_action_pressed("ui_down"):
			exit("Picking")

func exit_wander():
	exit("Wander")
