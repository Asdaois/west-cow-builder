extends Node

var state_machine: StateMachine
var enemy: Enemy
export(NodePath) onready var detection_range_area = get_node(detection_range_area) as Area2D
export(float) var speed: float = 130
export(float, 1, 2) var speed_up_bonus: float = 1.4


func enter():
	subscribe()


func exit(next_state):
	unsubscribe()
	if Globals.DEBUG:
		print("Exiting state: ", name)
	state_machine.change_to(next_state)


func subscribe() -> void:
	detection_range_area.connect("body_entered", self, "_on_body_entered")


func unsubscribe() -> void:
	detection_range_area.disconnect("body_entered", self
	, "_on_body_entered")
	pass

func process(_delta: float) -> void:
	if not is_instance_valid(enemy.target):
		exit("ChooseNextAction")
	
	enemy.calculate_velocity(speed, speed_up_bonus)


func _on_body_entered(body: Node) -> void:
	exit("ChooseNextAction")
