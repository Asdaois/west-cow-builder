extends Node

var state_machine: StateMachine
var npc: NPC

func enter():
  npc.velocity = Vector2.ZERO
  pass

func exit(next_state):
  if Globals.DEBUG:
    print("Exiting state: ", name)
  state_machine.change_to(next_state)

# Optional handler functions for game loop events
func process(delta):
  if distance_squared_to_town() > pow(20,2):
    go_to_town()
  else:
    npc.wait_for_new_state()
    exit("Work")
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

func go_to_town() -> void:
  npc._get_target_direction(Globals.town_hall)
  npc.apply_speed(1)


func distance_squared_to_town() -> float:
  return npc.global_position.distance_squared_to(Globals.town_hall.global_position)
