extends Node

func _ready() -> void:
  #$NPC.wait_for_new_state()
  $NPC.get_node("StateMachine").change_to("Work")
  #$NPC.get_node("StateMachine").start_machine()
  pass
