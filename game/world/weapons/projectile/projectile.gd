extends Area2D
class_name Projectile

export var speed: int = 25
var velocity: Vector2


func _physics_process(delta: float) -> void:
  position += velocity.normalized() * (delta * speed)


func _on_Timer_timeout() -> void:
  queue_free()


# warning-ignore:unused_argument
func _on_Projectile_area_entered(area: Area2D) -> void:
  queue_free()
