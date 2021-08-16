extends StateMachine

var state_machine: StateMachine
var npc: NPC

func enter():
	assert(npc.connect("work_changed", self, "_go_town_to_get_newjob") == 0)
	choose_work()
	pass


func exit(next_state):
	npc.disconnect("work_changed", self, "_go_town_to_get_newjob")
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


func choose_work():
	match npc.current_work:
		Enums.NPC_WORKS.Builder:
			state = $Builder
			pass
		Enums.NPC_WORKS.Defender:
			state = $Defender
			pass
		Enums.NPC_WORKS.Farmer:
			state = $Farmer
			pass
		Enums.NPC_WORKS.Jobless:
			state = $Jobless
			pass
		Enums.NPC_WORKS.Miner:
			state = $Miner
			pass


func _go_town_to_get_newjob():
	exit("GoBase")
