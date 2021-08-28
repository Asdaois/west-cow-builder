extends Node

var state_machine: StateMachine
var enemy: Enemy
export var run_speed : float = 120.0
export(float, 1, 2) var speed_up_bonus: float = 1.3
func enter() -> void:
	pass


func exit(next_state) -> void:
	if Globals.DEBUG:
		print("Exiting state: ", name)
	state_machine.change_to(next_state)


func process(_delta: float) -> void:
	if not is_instance_valid(enemy.target):
		exit("ChooseNextAction")
	
	enemy.calculate_velocity(run_speed, speed_up_bonus)
