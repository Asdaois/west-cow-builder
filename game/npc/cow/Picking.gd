# class_name
extends Node

var state_machine: StateMachine
var cow: Cow

func enter():
	print("I'm getting picked :D")

func exit(next_state):
	print("Apparently i'm not wanted :(")
	state_machine.change_to(next_state)

func process(_delta):
	cow.velocity = Vector2.ZERO

func input(event):
	if event.is_action_released("ui_down"):
		exit("Wander")
