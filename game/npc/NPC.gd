extends KinematicBody2D

export(Enums.NPC_WORKS) var current_work
export(float) var speed := 40.0

var velocity := Vector2.ZERO

func _physics_process(delta: float) -> void:
	_add_gravity()
	move_and_slide(velocity, Vector2.UP)


func _add_gravity():
	velocity.y += 10
