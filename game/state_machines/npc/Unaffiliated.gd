extends StateMachine

var state_machine: StateMachine
var npc: NPC

func enter():
	pass

func exit(next_state):
	# Stop the process
	if Globals.DEBUG:
		print("Exiting state: ", name)
	state_machine.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	return delta

func physics_process(delta):
	if is_instance_valid(npc.nugget_picked):
		npc.wait_for_new_state()
		# Getting affilitation to player
		npc.nugget_picked.queue_free()
		exit("GoBase")
	return delta

func input(event):
	return event

func unhandled_input(event):
	return event

func unhandled_key_input(event):
	return event

func notification(what, flag = false):
	return [what, flag]

