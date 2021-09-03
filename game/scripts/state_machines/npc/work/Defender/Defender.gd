extends StateMachine

var state_machine: StateMachine
export(NodePath) onready var attack_range = get_node(attack_range) as Area2D
export(NodePath) onready var weapon = get_node(weapon) as Node2D


func enter() -> void:
  weapon.visible = true
  if Globals.DEBUG:
    print("I'm goind to defend you baby")


func exit(next_state) -> void:
  if Globals.DEBUG:
    print("Exiting state: ", name)
  state_machine.change_to(next_state)

