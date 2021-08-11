# class_name
extends RigidBody2D
class_name Nugget
# custom signals

# enums - constant

# exports variables
export(Resource) var nugget = nugget as ItemResource

func _on_Area2D_area_entered(area):
	nugget.quantity += 1
	queue_free()
