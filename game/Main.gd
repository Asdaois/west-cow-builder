extends Node2D

func _ready() -> void:
	GameSignals.connect("change_ower", self, "add_scene_to_world")
	pass

func _on_Player_drop_nugget(nugget: PackedScene, direction: float , new_position: Vector2):
	var n: Node2D = nugget.instance()
	add_child(n)
	n.rotation = direction
	n.global_position = new_position


func add_scene_to_world(scene: Node) -> void:
	add_child(scene)
