# class_name
extends RigidBody2D
class_name Nugget

export(Resource) var nugget = nugget as ItemResource


func _on_Area2D_body_entered(body: Node) -> void:
	if body is Player:
		nugget.quantity += 1
		queue_free()
