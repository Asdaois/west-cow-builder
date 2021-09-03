extends Node

var state_machine: StateMachine
var npc: NPC


export(NodePath) onready var attackRangeArea = get_node(attackRangeArea) as Area2D


func enter():
  subscribes()


func exit(next_state):
  unsubscribes()
  if Globals.DEBUG:
    print("Exiting state: ", name)
  state_machine.change_to(next_state)


func subscribes() -> void:
  attackRangeArea.connect("body_entered", self, "get_target")


func unsubscribes() -> void:
  attackRangeArea.disconnect("body_entered", self, "get_target")


func get_target(body: Node) -> void:
  npc.targeted_enemy = body
  exit("Fight")
