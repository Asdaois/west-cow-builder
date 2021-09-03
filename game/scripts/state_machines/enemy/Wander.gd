extends Node
var Nugget := preload("res://world/nugget/Nugget.gd")


export(NodePath) onready var wander_timer = get_node(wander_timer) as Timer
export(NodePath) onready var stop_timer = get_node(stop_timer) as Timer
export(NodePath) onready var detection_range_area = get_node(detection_range_area) as Area2D

export(int) var wander_speed = 100
var state_machine: StateMachine
var enemy: Enemy

var max_wander_time := 1.0

func enter() -> void:
  subscribe()

  do_wander()


func exit(next_state):
  unsubscribe()
  if Globals.DEBUG:
    print("Exiting state: ", name)
  state_machine.change_to(next_state)

func subscribe() -> void:
  wander_timer.connect("timeout", self, "do_wander")
  stop_timer.connect("timeout", self, "stop_velocity")
  detection_range_area.connect("body_entered", self, "target_found")


func unsubscribe() -> void:
  wander_timer.disconnect("timeout", self, "do_wander")
  stop_timer.disconnect("timeout", self, "stop_velocity")
  detection_range_area.disconnect("body_entered", self, "target_found")


func do_wander():
  var wait_time := rand_range(1, max_wander_time)
  wander_timer.wait_time = wait_time
  stop_timer.wait_time = wait_time * 0.9 #Stop enemy for a moment
  wander_timer.start()
  stop_timer.start()
  var random_direction = [Vector2.RIGHT, Vector2.LEFT]
  random_direction.shuffle()
  enemy.velocity.x = random_direction[0].x * wander_speed


func stop_velocity() -> void:
  enemy.velocity.x = 0


func target_found(body: Node) -> void:
  if body is Nugget:
    enemy.target = body
    exit("SearchGold")

  if body is Player:
    enemy.target = body
    exit("ChasePlayer")
