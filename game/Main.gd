extends Node2D



func _on_Player_drop_nugget(nugget, direction, location):
	var n = nugget.instance()
	add_child(n)
	n.rotation = direction
	n.position = location
