extends StateMachine

var state_machine: StateMachine
var npc: NPC


func exit(next_state):
  # Stop the process
  if Globals.DEBUG:
    print("Exiting state: ", name)
  npc.get_parent().remove_child(npc)
  GameSignals.emit_signal("change_ower", npc)
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
