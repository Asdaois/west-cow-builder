extends Node

var state_machine: StateMachine
var npc: NPC
export(NodePath) onready var attackTimer = get_node(attackTimer) as Timer

func enter():
  attackTimer.connect("timeout", self, "attack")
  attack()
  print("Fightin")


func exit(next_state):
  attackTimer.disconnect("timeout", self, "attack")
  if Globals.DEBUG:
    print("Exiting state: ", name)
  state_machine.change_to(next_state)


func process(_delta: float) -> void:
  if not is_instance_valid(npc.targeted_enemy):
    exit("Aim")


func attack() -> void:
  npc.attack()
  attackTimer.start()

