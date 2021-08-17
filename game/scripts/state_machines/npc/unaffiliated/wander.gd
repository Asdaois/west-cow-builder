extends Node

var state_machine: StateMachine
var npc: NPC

func enter():
	assert(npc.wander_timer.connect("timeout", self, "_on_WanderTimer_timeout") == 0)
	npc.wander_timer.start()
	wander()
	pass
	#exit("next_state")

func exit(next_state):
	if Globals.DEBUG:
		print("Exiting state: ", name)
	npc.wander_timer.disconnect("timeout", self, "_on_WanderTimer_timeout")
	state_machine.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
	if is_instance_valid(npc.nugget):
		npc.velocity = Vector2.ZERO
		exit("FollowNugget")
	if npc.is_outside_wander_area:
		exit("GoBrokenCart")
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

func wander() -> void:
	npc.velocity.x = 0
	var random_direction = [Vector2.RIGHT, Vector2.LEFT]
	random_direction.shuffle()
	npc.velocity.x = random_direction[0].x * npc.speed


func _on_WanderTimer_timeout() -> void:
	yield(get_tree().create_timer(rand_range(0.1, 1)),"timeout")
	wander()
	npc.wander_timer.wait_time = rand_range(0.5, 2)
	npc.wander_timer.start()
