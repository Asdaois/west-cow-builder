extends StateMachine

var state_machine: StateMachine
var npc: NPC

func enter():
	GameUtils.enabled_node(self)
	state = get_child(0)
	
	pass

func exit(next_state):
	GameUtils.disabled_node(self)
	# Stop the process
	if Globals.DEBUG:
		print("Exiting state: ", name)
	state_machine.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	# Add handler code here
	return delta

func physics_process(delta):
	if is_instance_valid(npc.nugget_picked):
		npc.wait_for_new_state()
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

