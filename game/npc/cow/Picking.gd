# class_name
extends Node

var state_machie: StateMachine
var cow: Cow

func enter():
	print("I'm getting picked :D")

func exit(next_state):
	print("Apparently i'm not wanted :(")
	state_machie.change_to(next_state)

func process(_delta):
	cow.velocity = Vector2.ZERO
