extends Node

var state_machine: StateMachine
var enemy: Enemy

export(NodePath) onready var attack_CD_timer = get_node(attack_CD_timer) as Timer
export(NodePath) onready var attack_range = get_node(attack_range) as Area2D


func enter():
	subscribe()
	enemy.do_attack(enemy.target)
	pass

func exit(next_state):
	unsubscribe()
	if Globals.DEBUG:
		print("Exiting state: ", name)
	state_machine.change_to(next_state)

func subscribe() -> void:
	attack_CD_timer.connect("timeout", self, "do_attack")


func unsubscribe() -> void:
	attack_CD_timer.disconnect("timeout", self, "do_attack")

func process(_delta: float) -> void:
	if not is_instance_valid(enemy.target):
		exit("ChooseNextAction")

func do_attack() -> void:
	for body in attack_range.get_overlapping_bodies():
		if body.has_method("receive_damage"):
			enemy.do_attack(enemy.target)
