extends Node

var state_machine: StateMachine

func enter():
	if Globals.DEBUG:
		print("I'm jobless :(")
	pass

func exit(next_state):
	if Globals.DEBUG:
		print("Exiting state: ", name)
	state_machine.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	return delta

func physics_process(delta):
	return delta

func input(event):
	return event

func unhandled_input(event):
	return event

func unhandled_key_input(event):
	return event

func notification(what, flag = false):
	return [what, flag]
