extends Node

var state_machine: StateMachine
var enemy: Enemy
export(NodePath) onready var detection_range_area = get_node(detection_range_area) as Area2D

func enter():
	choose_next_action()

func exit(next_state):
	if Globals.DEBUG:
		print("Exiting state: ", name)
	state_machine.change_to(next_state)


func choose_next_action() -> void:
	var bodies: Array = detection_range_area.get_overlapping_bodies()
	var is_nugget_nearby := false
	var is_player_nearby := false
	for body in bodies:
		if body is Nugget:
			enemy.target = body
			is_nugget_nearby = true
			
		if body is Player:
			if not is_nugget_nearby:
				enemy.target = body
			is_player_nearby = true
		
	if is_nugget_nearby:
		exit("SearchGold")
	elif is_player_nearby:
		exit("ChasePlayer")
	else:
		exit("Wander")
