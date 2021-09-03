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
