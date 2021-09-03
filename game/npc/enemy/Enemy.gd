extends KinematicBody2D
class_name Enemy

export(float, 0, 200) var run_speed :float = 450
export(float, 150, 450) var gravity := 300
export(float, 0, 200) var range_distance : float = 150

export(int) var life := 10 setget set_life
func set_life(new_value) -> void:
  life = new_value
  if Globals.DEBUG:
    print(life)
  if life <= 0:
    queue_free()

var velocity := Vector2.ZERO
var target : PhysicsBody2D

export(NodePath) onready var attack_cooldown_timer = get_node(attack_cooldown_timer) as Timer
export(NodePath) onready var state_machine = get_node(state_machine) as StateMachine

func _ready() -> void:
  # Ininitialize statemachine
  var _c = GameStateManager.connect('game_over', self, "_on_player_died")
  for state in state_machine.get_children():
    if "enemy" in state:
      state["enemy"] = self


func _physics_process(delta: float) -> void:
  _add_gravity(delta)
  _move()


func _add_gravity(delta : float) -> void:
  if !is_on_floor():
    velocity.y += delta * gravity


func _move():
  velocity = move_and_slide(velocity, Vector2.UP)

func calculate_velocity(speed, speed_up_bonus = 1) -> void:
  velocity.x = calculate_follow_direction(target, speed_up_bonus) * speed

func calculate_follow_direction(to: Node2D, speed_up_bonus: float) -> float:
  if is_instance_valid(to):
    var direction := to.global_position.x - global_position.x
    # Don't follow if the distance is to little
    if abs(direction) < 10:
      return 0.0
    # Bost of speed if is necessary
    if abs(direction) < 150:
      return sign(direction) * speed_up_bonus
    return sign(direction)
  return 0.0

func _on_AttackRange_body_entered(body: Node) -> void:
  if body is Nugget:
    body.queue_free()

  if body.has_method("receive_damage"):
    do_attack(body)


func do_attack(objective) -> void:
  if not is_instance_valid(objective):
    return
  if objective.has_method("receive_damage"):
    objective.receive_damage(1)
  attack_cooldown_timer.start()


func _on_HitBox_area_entered(area: Area2D) -> void:
  if area is Projectile:
    self.life -= 1
