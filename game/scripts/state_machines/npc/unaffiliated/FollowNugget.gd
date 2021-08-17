extends Node

var state_machine: StateMachine
var npc: NPC

func enter():
	pass

func exit(next_state):
	if Globals.DEBUG:
		print("Exiting state: ", name)
	state_machine.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	follow_nugget()
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

func follow_nugget():
	if is_instance_valid(npc.nugget):
		npc._get_target_direction(npc.nugget)
		npc.velocity.x *= npc.speed * 1.5
	else:
		exit("Wander")
