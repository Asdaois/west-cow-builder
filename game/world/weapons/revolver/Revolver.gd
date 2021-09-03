extends Node2D

export(PackedScene) var Projectile: PackedScene
export(NodePath) onready var muzzle = get_node(muzzle) as Node2D

# warning-ignore:unused_argument
func fire(target_position: Vector2) -> void:
  var projectile: Area2D = Projectile.instance()
  get_tree().current_scene.call_deferred("add_child", projectile)
  projectile.global_position = muzzle.global_position
  projectile.velocity = muzzle.global_position.direction_to(target_position).normalized()
