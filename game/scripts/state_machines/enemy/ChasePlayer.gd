extends Node

var state_machine: StateMachine
var enemy: Enemy

export(NodePath) onready var detection_range_area = get_node(detection_range_area) as Area2D
export(NodePath) onready var attack_range = get_node(attack_range) as Area2D
export(NodePath) onready var attack_CD_timer = get_node(attack_CD_timer) as Timer

export(float) var speed: float = 130
export(float, 1, 2) var speed_up_bonus: float = 1.4


func enter():
	attack_CD_timer.start()
	subscribe()


func exit(next_state):
	unsubscribe()
	if Globals.DEBUG:
		print("Exiting state: ", name)
	state_machine.change_to(next_state)


func subscribe() -> void:
	detection_range_area.connect("body_entered", self, "_on_body_entered")
	attack_CD_timer.connect("timeout", self, "do_attack")

func unsubscribe() -> void:
	detection_range_area.disconnect("body_entered", self
	, "_on_body_entered")
	attack_CD_timer.disconnect("timeout", self, "do_attack")

func process(_delta: float) -> void:
	if not is_instance_valid(enemy.target):
		exit("ChooseNextAction")
	
	enemy.calculate_velocity(speed, speed_up_bonus)


func _on_body_entered(_body: Node) -> void:
	exit("ChooseNextAction")


func do_attack() -> void:
	for body in attack_range.get_overlapping_bodies():
		if body.has_method("receive_damage"):
			enemy.do_attack(body)
