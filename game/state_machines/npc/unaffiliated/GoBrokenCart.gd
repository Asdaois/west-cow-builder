extends Node

var state_machine: StateMachine
var npc: NPC

func enter():
	go_to_cart()
	pass

func exit(next_state):
	if Globals.DEBUG:
		print("Exiting state: ", name)
	state_machine.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	if distance_squared_to_cart() < pow(25,2):
		exit("Wander")
	if distance_squared_to_cart() > pow(150,2):
		go_to_cart()
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

func go_to_cart() -> void:
	npc._get_target_direction(npc.broken_cart)
	npc.apply_speed(0.8)

func distance_squared_to_cart() -> float:
	return npc.global_position.distance_squared_to(npc.broken_cart.global_position)
