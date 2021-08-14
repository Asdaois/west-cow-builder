extends Area2D

export(PackedScene) var npc_scene : PackedScene

var number_npc_spawned = 0
var max_number_npc_spawned = 2


# Broken Cart just have to spawn npc, but this work so stay here
func _on_BrokenCart_body_entered(body: Node):
	if body is Player:
		body.current_target = self


func _on_BrokenCart_body_exited(body: Node):
	if body is Player:
		body.current_target = null

